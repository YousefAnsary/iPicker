//
//  UIImageView+IPicker.swift
//  IPicker
//
//  Created by Yousef on 1/17/21.
//  Copyright © 2021 Yousef. All rights reserved.
//

import UIKit

extension UIImage {

    internal func maskWithColor( color:UIColor) -> UIImage {

         UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
         let context = UIGraphicsGetCurrentContext()!

         color.setFill()

         context.translateBy(x: 0, y: self.size.height)
         context.scaleBy(x: 1.0, y: -1.0)

         let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
         context.draw(self.cgImage!, in: rect)

         context.setBlendMode(CGBlendMode.sourceIn)
         context.addRect(rect)
         context.drawPath(using: CGPathDrawingMode.fill)

         let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return coloredImage!
    }
    
}
