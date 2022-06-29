//
//  MissionCellViewModel.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 16.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct MissionCellViewModel: Hashable {
    
    private let mission: Mission
    
    lazy var name: String = {
        return mission.name
    }()
    
    lazy var dateAndTime: String = {
        let date = Date(timeIntervalSince1970: TimeInterval(mission.dateTimestamp))
        return "\(date.justDate) \(Localizer.at.localized) \(date.justTime)"
    }()
    
    lazy var rocket: String = {
        return "\(mission.rocketName)/\(mission.rocketType)"
    }()
    
    lazy var days: String? = {
        guard let daysSinceLaunch = daysSinceLaunch else { return nil }
        return "\(daysSinceLaunch)"
    }()
    
    lazy var daysHeader: String? = {
        guard let daysSinceLaunch = daysSinceLaunch else { return nil }
        if daysSinceLaunch > 0 {
            return Localizer.daysSinceLaunch.localized
        } else {
            return Localizer.daysFromNow.localized
        }
    }()
    
    lazy var missionSuccessImageName: String? = {
        guard let launchSuccess = mission.launchSuccess else { return nil }
        return launchSuccess ? "checkmark" : "xmark"
    }()
    
    lazy var patchUrl: URL? = {
        guard let patchImage = mission.patchImage else { return nil }
        return URL(string: patchImage)
    }()
    
    private var daysSinceLaunch: Int? {
        return Date(timeIntervalSince1970: TimeInterval(mission.dateTimestamp)).daysSinceToday
    }
    
    init(mission: Mission) {
        self.mission = mission
    }
    
}
