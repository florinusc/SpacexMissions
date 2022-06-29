//
//  MainCoordinator.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 13.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var children = [Coordinator]()
    
    var parent: Coordinator?
    
    let window: UIWindow
    
    private let repository = OnlineRepository()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = LaunchListViewModel(repository: repository)
        let viewController = LaunchListViewController(viewModel: viewModel, coordinator: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
