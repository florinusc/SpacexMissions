//
//  Coordinator.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 13.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    func start()
}
