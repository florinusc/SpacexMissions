//
//  CustomInputToolbar.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

class CustomInputToolBar: UIToolbar {
    
    private let action: Selector?
    private let target: Any?
    
    init(frame: CGRect, target: Any?, action: Selector?) {
        self.action = action
        self.target = target
        super.init(frame: frame)
        barStyle = .default
        sizeToFit()
        isUserInteractionEnabled = true
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        let doneButton = UIBarButtonItem(title: Localizer.done.localized, style: .plain, target: target, action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setItems([spaceButton, doneButton], animated: false)
    }
    
}
