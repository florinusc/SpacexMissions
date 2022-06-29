//
//  Array+Extension.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
    
}
