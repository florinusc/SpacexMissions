//
//  CompanyResource.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 14.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct CompanyResource: Decodable {
    
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launchSites: Int
    let valuation: Int
    
    enum CodingKeys: String, CodingKey {
        case name, founder, founded, employees, valuation
        case launchSites = "launch_sites"
    }
    
}
