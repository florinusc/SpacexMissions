//
//  ToggleView.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit
import Combine

class ToggleView: UIView {
    
    private let toggleText: (String, String)?
    
    @Published private(set) var toggleValue: Bool
    
    private lazy var toggleStackView: UIStackView = {
        let leftLabel = UILabel()
        leftLabel.text = toggleText?.0
        let rightLabel = UILabel()
        rightLabel.text = toggleText?.1
        let stackView = UIStackView(arrangedSubviews: [leftLabel, toggle, rightLabel])
        stackView.spacing = 5
        return stackView
    }()
    private lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        return toggle
    }()
    private lazy var stackView: UIStackView = {
        let label = UILabel()
        label.text = title
        var subViews: [UIView] {
            if toggleText != nil {
                return [label, toggleStackView]
            } else {
                return [label, toggle]
            }
        }
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let title: String
    
    init(frame: CGRect, title: String, initialValue: Bool, toggleText: (String, String)? = nil) {
        self.title = title
        self.toggleValue = initialValue
        self.toggleText = toggleText
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(stackView)
        stackView.pinToSuperview()
    }
    
    @objc private func toggleChanged() {
        toggleValue = toggle.isOn
    }
    
}
