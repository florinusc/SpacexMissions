//
//  SessionManagerTests.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import XCTest
import Combine
@testable import SpacexMissions

class SessionManagerTests: XCTestCase {
    
    func test_dataRequest_withoutNetworkError_dataIsCorrect() throws {
        let sessionManager = createSUT(networkError: false, decoderError: false)
        let data = try awaitPublisher(sessionManager.dataRequest(RequestMock()))
        XCTAssertEqual(data, Data())
    }
    
    func test_dataRequest_withNetworkError_throwsError() {
        let sessionManager = createSUT(networkError: true, decoderError: false)
        XCTAssertThrowsError(try awaitPublisher(sessionManager.dataRequest(RequestMock())))
    }
    
    func test_decodableRequest_withoutNetworkError_mockIsCorrect() throws {
        let sessionManager = createSUT(networkError: false, decoderError: false)
        let decodable: DecodableMock = try awaitPublisher(sessionManager.decodableRequest(RequestMock()))
        XCTAssertEqual(decodable, DecodableMock(dummy: "test"))
    }
    
    func test_decodableRequest_withNetworkError_throwsError() {
        let sessionManager = createSUT(networkError: true, decoderError: false)
        let req: AnyPublisher<DecodableMock, Error> = sessionManager.decodableRequest(RequestMock())
        XCTAssertThrowsError(try awaitPublisher(req))
    }
    
    func test_decodableRequest_withDecoderError_throwsError() {
        let sessionManager = createSUT(networkError: false, decoderError: true)
        let req: AnyPublisher<DecodableMock, Error> = sessionManager.decodableRequest(RequestMock())
        XCTAssertThrowsError(try awaitPublisher(req))
    }
    
    private func createSUT(networkError: Bool, decoderError: Bool) -> SessionManager {
        let session = NetworkSessionMock(shouldReturnError: networkError)
        let dataDecoder = DataDecoderMock(shouldReturnError: decoderError)
        
        return SessionManager(session: session, dataDecoder: dataDecoder)
    }
    
}
