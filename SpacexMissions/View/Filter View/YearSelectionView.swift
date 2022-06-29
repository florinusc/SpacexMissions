//
//  YearSelectionView.swift
//  SpacexMissions
//
//  Created by Florin Uscatu on 17.06.2022.
//  Copyright © 2022 Florin-Alexandru Uscatu. All rights reserved.
//

import UIKit

class YearSelectionView: UIView {
    
    @Published private(set) var selectedIndex: Int
    
    private let years: [Int]
    private let title: String
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    private lazy var selectionLabel: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .center
        return label
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.isHidden = true
        textField.inputView = pickerView
        textField.inputAccessoryView = pickerViewToolBar
        return textField
    }()
    private lazy var selectionView: UIView = {
        let selectionViewBackgroundView = UIView()
        selectionViewBackgroundView.backgroundColor = .tertiarySystemFill
        selectionViewBackgroundView.layer.cornerRadius = 8.0
        selectionViewBackgroundView.clipsToBounds = true
        
        let heightConstraint = selectionViewBackgroundView.heightAnchor.constraint(equalToConstant: 35)
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        heightConstraint.isActive = true
        
        selectionViewBackgroundView.addSubview(selectionLabel)
        selectionLabel.pinToSuperview(topConstraint: 7, bottomConstraint: -7, leadingConstraint: 11, traillingConstriant: -11)
        
        selectionViewBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectStartYear)))
        
        return selectionViewBackgroundView
    }()
    private lazy var stackView: UIStackView = {
        let label = UILabel()
        label.text = title
        let stackView = UIStackView(arrangedSubviews: [label, textField, selectionView])
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var pickerViewToolBar: CustomInputToolBar = {
        let toolBar = CustomInputToolBar(frame:CGRect(x: 0, y: 0, width: 100, height: 50),
                                         target: self,
                                         action: #selector(dismissPicker))
        return toolBar
    }()
    
    init(frame: CGRect, years: [Int], initialIndex: Int, title: String) {
        self.years = years
        self.title = title
        self.selectedIndex = initialIndex
        super.init(frame: frame)
        addSubViews()
        if initialIndex >= 0, initialIndex < years.count {
            selectionLabel.text = years[safe: initialIndex]?.toString
            pickerView.selectRow(initialIndex, inComponent: 0, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(stackView)
        stackView.pinToSuperview()
    }
    
    @objc private func dismissPicker() {
        textField.resignFirstResponder()
    }
    
    @objc private func selectStartYear() {
        textField.becomeFirstResponder()
    }
    
}

extension YearSelectionView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row].toString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        selectionLabel.text = years[row].toString
    }
    
}
