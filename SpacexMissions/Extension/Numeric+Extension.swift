//
//  Numeric+Extension.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
