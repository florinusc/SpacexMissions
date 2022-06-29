//
//  Company.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct Company: Hashable {
    
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launchSites: Int
    let valuation: Int
    
}

extension Company {
    
    init(resource: CompanyResource) {
        self.name = resource.name
        self.founder = resource.founder
        self.founded = resource.founded
        self.employees = resource.employees
        self.launchSites = resource.launchSites
        self.valuation = resource.valuation
    }
    
}
