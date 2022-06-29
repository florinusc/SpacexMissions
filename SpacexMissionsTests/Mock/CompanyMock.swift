//
//  CompanyMock.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
@testable import SpacexMissions

extension Company {
    
    static func makeMock() -> Company {
        return Company(name: "SpaceX", founder: "Elon Musk", founded: 2002, employees: 123, launchSites: 3, valuation: 5)
    }
    
}
