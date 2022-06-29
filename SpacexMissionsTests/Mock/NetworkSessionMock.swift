//
//  NetworkSessionMock.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
import Combine
@testable import SpacexMissions

class NetworkSessionMock: NetworkSession {
    
    private let shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func loadData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if shouldReturnError {
            let urlError = URLError(URLError.Code(rawValue: 400))
            return Fail<(data: Data, response: URLResponse), URLError>(error: urlError).eraseToAnyPublisher()
        }
        
        let data = Data()
        let response = URLResponse()
        
        return Just<(data: Data, response: URLResponse)>((data, response)).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }
    
}
