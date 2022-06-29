//
//  UITableView+Extension.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
}
