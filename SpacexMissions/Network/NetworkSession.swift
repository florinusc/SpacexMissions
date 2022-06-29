//
//  NetworkSession.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 14.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
import Combine

protocol NetworkSession {
    func loadData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: NetworkSession {
    
    func loadData(from url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
    
}
