//
//  YDataPicker.swift
//  YPicker
//
//  Created by Yousef on 4/9/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public class YDataPicker: YPickerView {
    
    private let picker = UIPickerView()
    private var strings: [String] = []
    
    public var selectorColor: UIColor = .lightGray
    public var fontColor: UIColor = .black
    
    public var selectedIndex: Int! = 0
    
    public func setData<T>(data: [T], key: KeyPath<T, String>) {
        self.strings = data.map { $0[keyPath: key] }
    }
    
    public func setData(data: [String]) {
        self.strings = data
    }
    
    override func setupView(parent: UIView) {
        super.setupView(parent: parent)
        guard isFirstAppear else { return }
        setupNormalPicker()
    }
    
    override public func show(inView view: UIView) {
        pickerContainerHeight = 165
        super.show(inView: view)
    }
    
    override func doneBtnTapped() {
        super.doneBtnTapped()
        selectedIndex = picker.selectedRow(inComponent: 0)
    }
    
    override func upperViewTapped() {
        super.upperViewTapped()
        guard selectedIndex < strings.count else {return}
        picker.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
    private func setupNormalPicker() {
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.addSubview(picker)
        
        picker.constraintCenterX(to: pickerContainerView.centerXAnchor, constant: 0)
        picker.constraintCenterY(to: pickerContainerView.centerYAnchor, constant: 0)
        
//        picker.centerXAnchor.constraint(equalTo: pickerContainerView.centerXAnchor).isActive = true
//        picker.centerYAnchor.constraint(equalTo: pickerContainerView.centerYAnchor).isActive = true
        
        picker.subviews[1].backgroundColor = selectorColor
        picker.subviews[2].backgroundColor = selectorColor
    }
    
}

extension YDataPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return strings.count
    }
    
}

extension YDataPicker {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: strings[row], attributes: [NSAttributedString.Key.foregroundColor : fontColor])
        return attributedString
    }
    
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return strings[row]
//    }
    
}
