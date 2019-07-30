//
//  UIIntroductionView.swift
//  TestApp
//
//  Created by Sergey Koriukin on 02/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit


@IBDesignable
class UIIntroductionView: UIView {
    
    @IBInspectable var isPaletteBox: Bool = false
    
    @IBInspectable var isSelectedBox: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var selectedColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
          layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
 
        // fill view with colors
        if isPaletteBox {
          
            let saturationExponentTop:Float = 0.5
            let saturationExponentBottom:Float = 0.25
            let elementSize: CGFloat = 1.0
            let context = UIGraphicsGetCurrentContext()
            for y : CGFloat in stride(from: 0.0 ,to: rect.height, by: elementSize) {
                var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
                saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
                let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
                for x : CGFloat in stride(from: 0.0 ,to: rect.width, by: elementSize) {
                    let hue = x / rect.width
                    let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
                    context!.setFillColor(color.cgColor)
                    context!.fill(CGRect(x:x, y:y, width:elementSize,height:elementSize))
                }
            }
        } else {
            
            let context = UIGraphicsGetCurrentContext()!
           // selectedColor.set()
            selectedColor.setFill()
            context.fill(rect)
        }
        
        // check subview exist
        if let existView = self.viewWithTag(100) {
            existView.removeFromSuperview()
        }
        guard isSelectedBox else {
            return
        }
        // generate new subview
        let selectionSubView = getSelectionSubView(in: CGPoint(x: rect.maxX, y: rect.minY))
        // add subview and set it to front
        self.addSubview(selectionSubView)
        self.bringSubviewToFront(selectionSubView)
    }
    
    // generate subview with V and tag 100 to find later
    private func getSelectionSubView(in rightPoint: CGPoint) -> UIView {
        let shapeSize: CGSize = CGSize(width: 20, height: 20)
        let selectionView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: shapeSize.width, height: shapeSize.height))
            selectionView.alpha = 0.0
            selectionView.tag = 100
            selectionView.isUserInteractionEnabled = false
            let layer = CAShapeLayer()
            layer.path = getVPath(in: selectionView.frame).cgPath
            layer.strokeColor = UIColor.black.cgColor
            selectionView.layer.addSublayer(layer)
        return selectionView
    }
    // draw path to get 0 picture
    private func getVPath(in rect: CGRect) -> UIBezierPath {
  
            let pathRect = CGRect(x: 5, y: 5  , width: rect.width / 2  , height: rect.height / 2)
            let path = UIBezierPath(ovalIn: pathRect)
            path.addLine(to: CGPoint(x: 5, y: 10))
          //  path.addLine(to: CGPoint(x: 10, y: 10))
            let color = UIColor.black
            color.setFill()
            path.lineWidth = 2
            path.stroke()
    
        return path
    }
}
