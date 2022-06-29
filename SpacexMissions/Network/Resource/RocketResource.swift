//
//  RocketResource.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 14.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct RocketResource: Decodable {
    let name: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case name = "rocket_name"
        case type = "rocket_type"
    }
}
