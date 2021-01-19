//
//  IPicker.swift
//  IPicker
//
//  Created by Yousef on 9/6/19.
//  Copyright © 2019 Yousef. All rights reserved.
//

import UIKit

public class IPickerBottomView: UIView {
    
    //MARK: - Variables& Views
    private lazy var upperView: UIView = {
        let upperView = UIView()
        upperView.translatesAutoresizingMaskIntoConstraints = false
        upperView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        upperView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(upperViewTapped)))
        return upperView
    }()
    
    internal lazy var pickerContainerView: UIView = {
        let pickerContainerView = UIView()
        pickerContainerView.translatesAutoresizingMaskIntoConstraints = false
        pickerContainerView.backgroundColor = pickerBackgroundColor
        pickerContainerView.transform = CGAffineTransform(translationX: 0, y: 90)
        pickerContainerView.heightAnchor.constraint(equalToConstant: pickerContainerHeight).isActive = true
        pickerContainerView.layer.cornerRadius = 8
        pickerContainerView.layer.shadowColor = UIColor.black.cgColor
        pickerContainerView.layer.shadowOpacity = 0.4
        pickerContainerView.layer.shadowRadius = 2
        pickerContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        return pickerContainerView
    }()
    
    private lazy var doneBottomView: UIView = {
        let doneBottomView = UIView()
        doneBottomView.backgroundColor = pickerBackgroundColor
        doneBottomView.translatesAutoresizingMaskIntoConstraints = false
        doneBottomView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneBottomView.layer.cornerRadius = 8
        doneBottomView.layer.shadowColor = UIColor.black.cgColor
        doneBottomView.layer.shadowOpacity = 0.3
        doneBottomView.layer.shadowRadius = 2
        doneBottomView.layer.shadowOffset = CGSize(width: 0, height: -1)
        doneBottomView.alpha = 0
        doneBottomView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doneBtnTapped)))
        
        let doneLbl = UILabel()
        doneBottomView.addSubview(doneLbl)
        doneLbl.translatesAutoresizingMaskIntoConstraints = false
        doneLbl.centerXAnchor.constraint(equalTo: doneBottomView.centerXAnchor).isActive = true
        doneLbl.centerYAnchor.constraint(equalTo: doneBottomView.centerYAnchor).isActive = true
        doneLbl.text = doneBtnTitle
        doneLbl.textColor = doneTextColor
        
        return doneBottomView
    }()
    
    //Customizations
    private let style: IPicker.Style
    private var pickerBackgroundColor: UIColor!
    internal var textColor: UIColor!
    public var doneBtnTitle = "Done"
    public var doneTextColor = UIColor.systemBlue
    public var pickerContainerHeight: CGFloat = 230
    
    public init(style: IPicker.Style) {
        self.style = style
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupV(parent: UIView) {
        
        
        
    }
    
    //MARK: - Views Setup
    internal func setupView(parent: UIView) {
        
        handleStyle(parent: parent)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7060145548)
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        self.constraintTop(to: parent.safeAreaLayoutGuide.topAnchor, constant: 0)
        self.constraintBottom(to: parent.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        self.constraintLeading(to: parent.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        self.constraintTrailing(to: parent.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        
        self.addSubview(doneBottomView)
        doneBottomView.constraintBottom(to: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        doneBottomView.constraintLeading(to: self.safeAreaLayoutGuide.leadingAnchor, constant: 12)
        doneBottomView.constraintTrailing(to: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        fadeDoneButtonView()
        
        self.addSubview(pickerContainerView)
        pickerContainerView.constraintBottom(to: doneBottomView.safeAreaLayoutGuide.topAnchor, constant: -8)
        pickerContainerView.constraintLeading(to: self.safeAreaLayoutGuide.leadingAnchor, constant: 12)
        pickerContainerView.constraintTrailing(to: self.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        
        self.addSubview(upperView)
        upperView.constraintTop(to: safeAreaLayoutGuide.topAnchor, constant: 0)
        upperView.constraintLeading(to: safeAreaLayoutGuide.leadingAnchor, constant: 0)
        upperView.constraintTrailing(to: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        upperView.constraintBottom(to: pickerContainerView.topAnchor, constant: 0)
        animatePickerContainerUpWithFade()
        
    }
    
    private func handleStyle(parent: UIView) {
        switch style {
        case .dark:
            pickerBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
            textColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        case .light:
            pickerBackgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
            textColor = #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
        case .autoLight:
            if #available(iOS 12.0, *) {
                let userInterfaceStyle = parent.traitCollection.userInterfaceStyle
                pickerBackgroundColor =  userInterfaceStyle == .dark ? #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555) : #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                textColor = userInterfaceStyle == .dark ? #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
            } else {
                pickerBackgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                textColor = #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
            }
        case .autoDark:
            if #available(iOS 12.0, *) {
                let userInterfaceStyle = parent.traitCollection.userInterfaceStyle
                pickerBackgroundColor =  userInterfaceStyle == .dark ? #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555) : #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                textColor = userInterfaceStyle == .dark ? #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
            } else {
                pickerBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.07843137255, alpha: 0.8487264555)
                textColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
            }
        }
    }
    
    //MARK: - Actions Handlers
    @objc internal func upperViewTapped() {
        dismissView()
    }
    
    @objc internal func doneBtnTapped() {
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.doneBottomView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: { [weak self] bool in
            self?.doneBottomView.transform = .identity
            self?.dismissView()
        })
        
    }
    
    //MARK: - View Show& Dismiss
    public func show(inView view: UIView) {
        
        self.isHidden = false
        self.alpha = 1
        setupView(parent: view)
        
    }
    
    internal func dismissView() {
        
        animatePickerContainerDownWithFade()
        
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] bool in
            self?.isHidden = true
            self?.removeFromSuperview()
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
    
    internal func fadeDoneButtonView() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.doneBottomView.alpha = 1
        })
    }
    
}
