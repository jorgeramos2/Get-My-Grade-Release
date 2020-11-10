//
//  customUITextfield.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 06/01/20.
//  Copyright © 2020 ArturoMendez. All rights reserved.
//

import UIKit

@IBDesignable
    open class customUITextField: UITextField {

        func setup() {
          let bottomLine = CALayer()
                bottomLine.frame = CGRect(x: 0, y: frame.height-2, width: frame.width, height: 2)
                bottomLine.backgroundColor = UIColor.init(red: 152/255, green: 25/255, blue: 25/255, alpha: 1).cgColor
                borderStyle = .none
                layer.addSublayer(bottomLine)
    }
   

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
public extension UITextField
{
    func shake() {
              let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
              animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
              animation.duration = 0.6
              animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
              layer.add(animation, forKey: "shake")
          }
}
