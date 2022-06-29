//
//  LaunchFilterView.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 16.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit
import Combine

class LaunchFilterView: UIView {
    
    private let years: [Int]
    
    var startYearIndexValue: Published<Int>.Publisher {
        return startYearSelectionView.$selectedIndex
    }
    
    var endYearIndexValue: Published<Int>.Publisher {
        return endYearSelectionView.$selectedIndex
    }
    
    var launchSuccessToggleValue: Published<Bool>.Publisher {
        return launchSuccessToggleView.$toggleValue
    }
    
    var orderToggleValue: Published<Bool>.Publisher {
        return orderToggleView.$toggleValue
    }
    
    private lazy var startYearSelectionView: YearSelectionView = {
        let yearSelectionView = YearSelectionView(frame: .zero, years: years, initialIndex: 0, title: Localizer.from.localized)
        return yearSelectionView
    }()
    private lazy var endYearSelectionView: YearSelectionView = {
        let yearSelectionView = YearSelectionView(frame: .zero, years: years, initialIndex: years.count - 1, title: Localizer.to.localized)
        return yearSelectionView
    }()
    private lazy var launchSuccessToggleView: ToggleView = {
        let toggleView = ToggleView(frame: .zero, title: Localizer.successfulLaunches.localized, initialValue: false)
        return toggleView
    }()
    private lazy var orderToggleView: ToggleView = {
        let toggleView = ToggleView(frame: .zero,
                                    title: Localizer.order.localized,
                                    initialValue: false,
                                    toggleText: (Localizer.asc.localized, Localizer.dsc.localized))
        return toggleView
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startYearSelectionView, endYearSelectionView, launchSuccessToggleView, orderToggleView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var launchSuccessCancellable: AnyCancellable!
    private var orderCancellable: AnyCancellable!
    private var startYearCancellable: AnyCancellable!
    private var endYearCancellable: AnyCancellable!
    
    init(frame: CGRect, years: [Int]) {
        self.years = years
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(mainStackView)
        mainStackView.pinToSuperview(with: 10)
        
        addBorder()
    }
    
    private func addBorder() {
        let borderView = UIView()
        borderView.backgroundColor = .lightGray
        addSubview(borderView)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        borderView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
