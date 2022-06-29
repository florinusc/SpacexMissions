//
//  Localizer.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 14.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

enum Localizer: String {
    
    case generalError
    case networkError
    case company
    case launches
    case companyInfo
    case mission
    case dateTime
    case rocket
    case daysFromNow
    case daysSinceLaunch
    case at
    case wikipedia
    case article
    case video
    case cancel
    case from
    case to
    case done
    case successfulLaunches
    case order
    case asc
    case dsc
    
    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
    
}
