//
//  NoteExtensions.swift
//  Note
//
//  Created by Sergey Koriukin on 21/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import UIKit




extension Note{
    
    var json: [String: Any] {
        
        var toJson: [String: Any] = [:]
        
        toJson["uid"] = uid
        toJson["title"]  = title
        toJson["content"]  = content
        
        if let date = destroyDate {
            
            toJson["destroyDate"] = date.timeIntervalSince1970
        }
        if color != .white {
            
            toJson["color"] = color.toHexString()
        }
        if importance != Importance.normal {
            
            toJson["importance"] = importance.rawValue
        }
        return toJson
    }
    
    static func parse(json:[String: Any]) -> Note? {
        
        let uid:String = json["uid"] as! String
        let title:String = json["title"] as! String
        let content:String = json["content"] as! String
        var color:UIColor{
            if let jsonColor = json["color"] as? String{
                return UIColor(hexString: jsonColor)
            } else {
                return UIColor.white
            }
        }
        var importance: Importance {
            if let jsonImportance = json["importance"] as? String {
                return Importance(rawValue: jsonImportance)!
            } else{
                return Importance.normal
            }
        }
        var destroyDate:Date?{
            if let jsonDestroyDate = json["destroyDate"] as? TimeInterval {
                return Date(timeIntervalSince1970: jsonDestroyDate)
            } else {
                return nil
            }
        }
        
        
        return Note(uid: uid,
                    title: title,
                    content: content,
                    color: color,
                    importance: importance,
                    destroyDate: destroyDate
        )
        
    }
}


extension UIColor {

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
}
extension UIColor {
    convenience init?(hex: String) {
        var hexValue = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexValue = hexValue.replacingOccurrences(of: "#", with: "")
        
        var rgba: Int = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexValue.count
        
        guard Scanner(string: hexValue).scanInt(&rgba) else { return nil }
        
        if length == 8 {
            r = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgba & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgba & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            guard !r.isNaN, !g.isNaN, !b.isNaN, !a.isNaN else { return (0, 0, 0, 0) }
            return (r, g, b, a)
        }
        return (0, 0, 0, 0)
    }
    
    var hue: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a){
            guard !h.isNaN, !s.isNaN, !b.isNaN, !a.isNaN else { return (0, 0, 0, 0) }
            return (h, s, b, a)
        }
        return (0, 0, 0, 0)
    }
    
    var rgbaHexString: String {
        return String(format: "#%02x%02x%02x%02x", Int(rgba.red * 255), Int(rgba.green * 255), Int(rgba.blue * 255), Int(rgba.alpha * 255))
    }
}

