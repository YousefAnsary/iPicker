//
//  IUIViewExtension.swift
//  YPicker
//
//  Created by Yousef on 4/9/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import UIKit

extension UIView {
    
    internal func constraintTop(to constraint: NSLayoutYAxisAnchor, constant: CGFloat) {
        self.topAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    internal func constraintBottom(to constraint: NSLayoutYAxisAnchor, constant: CGFloat) {
        self.bottomAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    internal func constraintLeading(to constraint: NSLayoutXAxisAnchor, constant: CGFloat) {
        self.leadingAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    internal func constraintTrailing(to constraint: NSLayoutXAxisAnchor, constant: CGFloat) {
        self.trailingAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    internal func constraintCenterX(to constraint: NSLayoutXAxisAnchor, constant: CGFloat) {
        self.centerXAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    internal func constraintCenterY(to constraint: NSLayoutYAxisAnchor, constant: CGFloat) {
        self.centerYAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    internal func constraintHeight(constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    internal func constraintWidth(constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    internal func errorShakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
}
