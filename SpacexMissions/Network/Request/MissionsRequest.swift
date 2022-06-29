//
//  MissionsRequest.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct MissionsRequest: Request {
    
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = "/v3/launches"
        
        return components.url
    }
    
}
