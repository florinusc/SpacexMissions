//
//  MissionCell.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 15.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

class MissionCell: UITableViewCell {
    
    private lazy var nameHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = Localizer.mission.localized
        label.setUpAsHeader()
        return label
    }()
    private lazy var dateAndTimeHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = Localizer.dateTime.localized
        label.setUpAsHeader()
        return label
    }()
    private lazy var rocketHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = Localizer.rocket.localized
        label.setUpAsHeader()
        return label
    }()
    private lazy var daysHeaderLabel: UILabel = {
        let label = UILabel()
        label.setUpAsHeader()
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.setUpAsValue()
        return label
    }()
    private lazy var dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.setUpAsValue()
        return label
    }()
    private lazy var rocketLabel: UILabel = {
        let label = UILabel()
        label.setUpAsValue()
        return label
    }()
    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.setUpAsValue()
        return label
    }()
    private lazy var missionPatchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 75)
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        heightConstraint.isActive = true
        return imageView
    }()
    private lazy var missionSuccessImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.tintColor = .label
        return imageView
    }()
    
    var viewModel: MissionCellViewModel? {
        didSet {
            setUp(with: viewModel)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        let nameStackView = UIStackView(arrangedSubviews: [nameHeaderLabel, nameLabel])
        nameStackView.axis = .horizontal
        nameStackView.spacing = 10
        let dateAndTimeStackView = UIStackView(arrangedSubviews: [dateAndTimeHeaderLabel, dateAndTimeLabel])
        dateAndTimeStackView.axis = .horizontal
        dateAndTimeStackView.spacing = 10
        let rocketStackView = UIStackView(arrangedSubviews: [rocketHeaderLabel, rocketLabel])
        rocketStackView.axis = .horizontal
        rocketStackView.spacing = 10
        let daysStackView = UIStackView(arrangedSubviews: [daysHeaderLabel, daysLabel])
        daysStackView.axis = .horizontal
        daysStackView.spacing = 10
        let labelsStackView = UIStackView(arrangedSubviews: [nameStackView, dateAndTimeStackView, rocketStackView, daysStackView])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 5
        
        let mainStackView = UIStackView(arrangedSubviews: [missionPatchImageView, labelsStackView, missionSuccessImageView])
        
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.alignment = .top
        
        addSubview(mainStackView)
        mainStackView.pinToSuperview(with: 10)
    }
    
    private func setUp(with viewModel: MissionCellViewModel?) {
        guard var viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        dateAndTimeLabel.text = viewModel.dateAndTime
        rocketLabel.text = viewModel.rocket
        daysLabel.text = viewModel.days
        daysHeaderLabel.text = viewModel.daysHeader

        missionPatchImageView.setImage(with: viewModel.patchUrl)
        
        if let missionSuccessImageName = viewModel.missionSuccessImageName {
            missionSuccessImageView.image = UIImage(systemName: missionSuccessImageName)
        } else {
            missionPatchImageView.image = nil
        }
    }
    
}

fileprivate extension UILabel {
    
    func setUpAsHeader() {
        font = .boldSystemFont(ofSize: 17)
        setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    func setUpAsValue() {
        numberOfLines = 0
        textAlignment = .right
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
}
