//
//  DataDecoder.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
import Combine

protocol DataDecoder {
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error>
}

