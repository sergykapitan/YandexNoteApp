//
//  NoteExtentionTest.swift
//  TestAppTests
//
//  Created by Sergey Koriukin on 30/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import XCTest
@testable import TestApp

class NoteExtentionTest: XCTestCase {

    func testJSONCreated() {
        let date = Date()
        let note = Note(uid: "42", title: "First", content: "Text", color: .red,
                        importance: .important, destroyDate: date)
        let json = note.json
        
        XCTAssertEqual(json["uid"] as! String, "42")
        XCTAssertEqual(json["title"] as! String, "First")
        XCTAssertEqual(json["content"] as! String, "Text")
        XCTAssertEqual((json["color"] as! String), "#ff0000")
        XCTAssertEqual(json["importance"] as! String, Importance.important.rawValue)
        XCTAssertEqual(json["destroyDate"] as! TimeInterval, date.timeIntervalSince1970)
    
    }
    func testJsonCreated() {
        let note = Note(uid: "42", title: "First", content: "Text", color: .white,
                        importance: .normal, destroyDate: nil)
        let json = note.json
        
        
        XCTAssertNil(json["color"])
        XCTAssertNil(json["importance"])
        XCTAssertNil(json["destroyDate"])
        
    }
    

}
