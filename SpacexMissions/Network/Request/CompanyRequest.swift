//
//  CompanyRequest.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

struct CompanyRequest: Request {
    
    var url: URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = "/v4/company"
        
        return components.url
    }
    
}
