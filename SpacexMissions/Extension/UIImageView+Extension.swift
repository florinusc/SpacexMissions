//
//  UIImageView+Extension.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 16.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        guard let url = url else { return }
        DispatchQueue.main.async {
            self.kf.setImage(with: url)
        }
    }
    
}
