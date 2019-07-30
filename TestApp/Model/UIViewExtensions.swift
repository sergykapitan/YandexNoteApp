//
//  UIViewExtensions.swift
//  TestApp
//
//  Created by Sergey Koriukin on 18/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit

extension UIView {
    func emptyList(_ show: Bool, _ message: String = "", _ y: CGFloat = -1) {
        let tag = 800045
        if show {
            let viewHeight = self.bounds.size.height
            let viewWidth = self.bounds.size.width
            var y = y
            if y < 0 {
                y = viewHeight/2 - 10
            }
            let label = UILabel(frame: CGRect(x: 0, y: y, width: viewWidth, height: 20))
            label.textColor = UIColor.black
            label.text = message
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont(name: "HelveticaNeue", size: 16)
            label.tag = tag
            self.addSubview(label)
        } else {
            if let label = self.viewWithTag(tag) as? UILabel {
                label.removeFromSuperview()
            }
        }
    }
}

