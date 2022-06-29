//
//  DataDecoderMock.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
import Combine
@testable import SpacexMissions

class DataDecoderMock: DataDecoder {
    
    private let shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func decode<T>(_ data: Data) -> AnyPublisher<T, Error> where T : Decodable {
        if shouldReturnError {
            return Fail<T, Error>(error: CustomError.general).eraseToAnyPublisher()
        }
        return Just<T>(DecodableMock(dummy: "test") as! T).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}

struct DecodableMock: Decodable, Equatable {
    let dummy: String
}
