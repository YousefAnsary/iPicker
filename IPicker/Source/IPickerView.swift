//
//  IPicker.swift
//  IPicker
//
//  Created by Yousef on 9/6/19.
//  Copyright © 2019 Yousef. All rights reserved.
//

import UIKit

public class IPickerView: UIView {
    
    //Boolean Handles View Setup
    internal var isFirstAppear = true
    
    //Views
    internal let upperView = UIView()
    internal let pickerContainerView = UIView()
    internal let doneBottomView = UIView()
    internal let doneLabel = UILabel()
    
    //Customizations
    public var doneBtnTitle = "Done"
    public var doneTextColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    public var pickerContainerHeight: CGFloat = 230
    public var pickerBackgroundColor: UIColor = #colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 1, alpha: 1)
    
    //MARK: - Views Setup
    internal func setupView(parent: UIView) {
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4043771404)
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        
//        self.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor).isActive = true
//        self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        self.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        self.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.constraintTop(to: parent.safeAreaLayoutGuide.topAnchor, constant: 0)
        self.constraintBottom(to: parent.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.constraintLeading(to: parent.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        self.constraintTrailing(to: parent.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        
        guard isFirstAppear else {return}
        setupDoneBottomView()
        setupPickerContainerView()
        setupUpperView()
    }
    
    internal func setupUpperView() {
        self.addSubview(upperView)
        upperView.translatesAutoresizingMaskIntoConstraints = false
        upperView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
//        upperView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        upperView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//        upperView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//        upperView.bottomAnchor.constraint(equalTo: self.pickerContainerView.topAnchor, constant: 0).isActive = true
        
        upperView.constraintTop(to: safeAreaLayoutGuide.topAnchor, constant: 0)
        upperView.constraintLeading(to: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        upperView.constraintTrailing(to: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        upperView.constraintBottom(to: pickerContainerView.topAnchor, constant: 0)
        
        
        upperView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperViewTapped)))
    }
    
    internal func setupPickerContainerView() {
        self.addSubview(pickerContainerView)
        pickerContainerView.backgroundColor = pickerBackgroundColor
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.transform = CGAffineTransform(translationX: 0, y: 90)
        
//        pickerContainerView.bottomAnchor.constraint(equalTo: doneBottomView.safeAreaLayoutGuide.topAnchor, constant: -8).isActive = true
//        pickerContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
//        pickerContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        
        pickerContainerView.constraintBottom(to: doneBottomView.safeAreaLayoutGuide.topAnchor, constant: -8)
        pickerContainerView.constraintLeading(to: self.safeAreaLayoutGuide.leadingAnchor, constant: 12)
        pickerContainerView.constraintTrailing(to: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        pickerContainerView.heightAnchor.constraint(equalToConstant: pickerContainerHeight).isActive = true
        
        pickerContainerView.layer.cornerRadius = 8
        pickerContainerView.layer.shadowColor = UIColor.black.cgColor
        pickerContainerView.layer.shadowOpacity = 0.4
        pickerContainerView.layer.shadowRadius = 2
        pickerContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        animatePickerContainerUpWithFade()
    }
    
    internal func setupDoneBottomView() {
        self.addSubview(doneBottomView)
        doneBottomView.backgroundColor = pickerBackgroundColor
        doneBottomView.translatesAutoresizingMaskIntoConstraints = false
        
//        doneBottomView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
//        doneBottomView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
//        doneBottomView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        
        doneBottomView.constraintBottom(to: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        doneBottomView.constraintLeading(to: self.safeAreaLayoutGuide.leadingAnchor, constant: 12)
        doneBottomView.constraintTrailing(to: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        doneBottomView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        doneBottomView.addSubview(doneLabel)
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        doneLabel.centerXAnchor.constraint(equalTo: doneBottomView.centerXAnchor).isActive = true
        doneLabel.centerYAnchor.constraint(equalTo: doneBottomView.centerYAnchor).isActive = true
        doneLabel.text = doneBtnTitle
        doneLabel.textColor = doneTextColor
        doneBottomView.layer.cornerRadius = 8
        doneBottomView.layer.shadowColor = UIColor.black.cgColor
        doneBottomView.layer.shadowOpacity = 0.3
        doneBottomView.layer.shadowRadius = 2
        doneBottomView.layer.shadowOffset = CGSize(width: 0, height: -1)
        doneBottomView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.doneBottomView.alpha = 1
        })
        doneBottomView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneBtnTapped)))
    }
    
    //MARK: - Actions Handlers
    @objc internal func upperViewTapped() {
        dismissView()
    }
    
    @objc internal func doneBtnTapped() {
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.doneBottomView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }, completion: { [weak self] bool in
                self?.doneBottomView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.dismissView()
        })
        
    }
    
    //MARK: - View Show& Dismiss
    public func show(inView view: UIView) {
        
        if isFirstAppear {
            setupView(parent: view)
            isFirstAppear = false
        } else {
            self.isHidden = false
            self.alpha = 1
            animatePickerContainerUpWithFade()
        }
        
    }
    
    internal func dismissView() {
        
        animatePickerContainerDownWithFade()
        
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.alpha = 0
            }, completion: { [weak self] bool in
                self?.isHidden = true
        })
        
    }
    
    //MARK: - Animation
    internal func animatePickerContainerUpWithFade() {
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.pickerContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
            self?.pickerContainerView.alpha = 1
        }
    }
    
    internal func animatePickerContainerDownWithFade() {
        UIView.animate(withDuration: 0.6) { [weak self] in
            self?.pickerContainerView.transform = CGAffineTransform(translationX: 0, y: 90)
            self?.pickerContainerView.alpha = 0
        }
    }
    
}
