//
//  RequestMock.swift
//  SpacexMissionsTests
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation
@testable import SpacexMissions

struct RequestMock: Request {
    
    var url: URL? {
        return URL(string: "www.google.com")
    }
    
}
