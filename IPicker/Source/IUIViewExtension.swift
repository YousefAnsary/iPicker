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
    
}
