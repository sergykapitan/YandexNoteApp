//
//  Note.swift
//  Note
//
//  Created by Sergey Koriukin on 19/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import  Foundation
import UIKit
import CocoaLumberjack

struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let destroyDate: Date?
    
    init(uid: String = UUID().uuidString, title: String, content: String, color:UIColor = UIColor.white, importance:Importance, destroyDate: Date?) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.destroyDate = destroyDate
    }
}


enum Importance: String {
    
    case unimportant
    case normal
    case important
    
}
