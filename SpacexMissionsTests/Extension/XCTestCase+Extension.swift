//
//  XCTestCase+Extension.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import XCTest
import Combine

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // Use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Await the expectation that was
        // created at the top of the test, and once done,
        // also cancel cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Pass the original file and line number that
        // the utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
