//
//  CustomError.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 14.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case general
    case network
    case custom(message: String)
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .general: return Localizer.generalError.localized
        case .network: return Localizer.networkError.localized
        case .custom(let message): return message
        }
    }
}
