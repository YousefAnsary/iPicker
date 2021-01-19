//
//  IDatePicker.swift
//  IPicker
//
//  Created by Yousef on 4/9/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

public extension IPicker {
    class BottomViewDatePicker: IPickerBottomView {
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.datePickerMode = pickerMode
        if #available(iOS 13.4, *) { datePicker.preferredDatePickerStyle = .wheels }
        datePicker.date = selectedDate ?? Date()
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.setValue(textColor, forKeyPath: "textColor")
        return datePicker
    }()
    
    private let pickerMode: UIDatePicker.Mode
    
    private var doneBtnDidTapped: ((Date)-> Void)?
    private var didCancelled: (()-> Void)?
        
    public var selectedDate: Date?
    public var minimumDate: Date?
    public var maximumDate: Date?
        
    public init(style: IPicker.Style, pickerMode: UIDatePicker.Mode) {
        self.pickerMode = pickerMode
        super.init(style: style)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setupView(parent: UIView) {
        super.setupView(parent: parent)
        
//        guard isFirstAppear else {return}
        setupDatePicker()
        
    }
    
    public func didSelect(_ completion: @escaping (Date)-> Void) {
        self.doneBtnDidTapped = completion
    }
    
    public func didCancelled(_ completion: @escaping ()-> Void) {
        self.didCancelled = completion
    }
    
    private func setupDatePicker() {
        pickerContainerView1.addSubview(datePicker)
        datePicker.constraintCenterX(to: pickerContainerView1.centerXAnchor, constant: 0)
        datePicker.constraintCenterY(to: pickerContainerView1.centerYAnchor, constant: 0)
    }
    
//    override public func show(inView view: UIView) {
//        super.show(inView: view)
//
////        datePicker.datePickerMode = pickerMode
////        datePicker.date = selectedDate ?? Date()
////        datePicker.minimumDate = minimumDate
////        datePicker.maximumDate = maximumDate
//
//    }
    
    override func doneBtnTapped() {
        super.doneBtnTapped()
        selectedDate = datePicker.date
        doneBtnDidTapped?(selectedDate!)
    }
    
    override func upperViewTapped() {
        super.upperViewTapped()
        datePicker.date = selectedDate ?? Date()
        didCancelled?()
    }
    
}
}
