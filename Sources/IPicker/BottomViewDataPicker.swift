//
//  IDataPicker.swift
//  IPicker
//
//  Created by Yousef on 4/9/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public extension IPicker {
class BottomViewDataPicker: IPickerBottomView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private var strings: [String] = []
    
    private var doneBtnDidTapped: ((Int)-> Void)?
    private var didChangeValue: ((Int)-> Void)?
    private var didCancelled: (()-> Void)?
    
//    public var selectorColor: UIColor = .lightGray
//    public var fontColor: UIColor = .white//.black
    
    public var selectedIndex: Int! = 0
    
    public func setData<T>(data: [T], key: KeyPath<T, String>) {
        self.strings = data.map { $0[keyPath: key] }
    }
    
    public func setData(data: [String]) {
        self.strings = data
    }
    
    public func didSelect(_ completion: @escaping (Int)-> Void) {
        self.doneBtnDidTapped = completion
    }
    
    public func didCancelled(_ completion: @escaping ()-> Void) {
        self.didCancelled = completion
    }
    
    public func didValueChanged(_ completion: @escaping (Int)-> Void) {
        self.didChangeValue = completion
    }
    
    override public func show(inView view: UIView) {
        pickerContainerHeight = 190
        super.show(inView: view)
    }
    
    override func setupView(parent: UIView) {
        super.setupView(parent: parent)
//        guard isFirstAppear else { return }
        
        pickerContainerView1.addSubview(picker)
        picker.constraintCenterX(to: pickerContainerView1.centerXAnchor, constant: 0)
        picker.constraintCenterY(to: pickerContainerView1.centerYAnchor, constant: 0)
        guard selectedIndex < picker.numberOfRows(inComponent: 0) else {return}
        picker.selectRow(selectedIndex, inComponent: 0, animated: true)
        
    }
    
    override func doneBtnTapped() {
        super.doneBtnTapped()
        selectedIndex = picker.selectedRow(inComponent: 0)
        doneBtnDidTapped?(selectedIndex)
    }
    
    override func upperViewTapped() {
        super.upperViewTapped()
        didCancelled?()
        guard selectedIndex < picker.numberOfRows(inComponent: 0) else {return}
        picker.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return strings.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didChangeValue?(row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: strings[row], attributes: [NSAttributedString.Key.foregroundColor : textColor!])
        return attributedString
    }
    
}
}
