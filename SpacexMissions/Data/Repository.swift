//
//  Repository.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
import Combine

protocol Repository {
    func fetchCompany() -> AnyPublisher<Company, Error>
    func fetchMissions() -> AnyPublisher<[Mission], Error>
}
