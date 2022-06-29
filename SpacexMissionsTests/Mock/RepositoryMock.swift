//
//  RepositoryMock.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
import Combine
@testable import SpacexMissions

class RepositoryMock: Repository {
    
    private let shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func fetchCompany() -> AnyPublisher<Company, Error> {
        if shouldReturnError {
            return Fail<Company, Error>(error: CustomError.general).eraseToAnyPublisher()
        }
        return Just<Company>(Company.makeMock()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func fetchMissions() -> AnyPublisher<[Mission], Error> {
        if shouldReturnError {
            return Fail<[Mission], Error>(error: CustomError.general).eraseToAnyPublisher()
        }
        let missions: [Mission] = [.makeFalconMock(), .makeSatelliteMock(), .makeStarlinkMock()]
        return Just<[Mission]>(missions).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}
