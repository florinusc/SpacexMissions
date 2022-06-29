//
//  UIViewController+Extension.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(for error: Error, with handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.view.tintColor = .systemBlue
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func loader() -> UIViewController {
        let loadingViewController = LoadingViewController()
        add(loadingViewController)
        return loadingViewController
    }
    
    func stopLoader(loader: UIViewController) {
        loader.remove()
    }
    
}
