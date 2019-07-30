//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Sergey Koriukin on 24/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {
    
    var fileNotebook: FileNotebook!
    var note: Note!

    override func setUp() {
        super.setUp()
        
        fileNotebook = FileNotebook()
        note = Note(uid: "42", title: "First", content: "Text", color: .white, importance: .normal, destroyDate: Date())
        
    }

    override func tearDown() {
        fileNotebook = nil
        note = nil
    }

    func testNoteAdd() {
        fileNotebook.add(noteToAdd: note)
        XCTAssertGreaterThan(fileNotebook.notes.count, 0)
        
    }
    
    func testDoubleNoteNotAdd() {
        let secondNote = Note(uid: "42", title: "First", content: "Text", color: .white, importance: .normal, destroyDate: Date())
        fileNotebook.add(noteToAdd: note)
        fileNotebook.add(noteToAdd: secondNote)
        
        XCTAssertEqual(fileNotebook.notes.count, 1)
        
    }
    func testNoteRemoved() {
        fileNotebook.add(noteToAdd: note)
        
        fileNotebook.remove(with: "2")
        XCTAssertEqual(fileNotebook.notes.count, 1)
        
        fileNotebook.remove(with: "42")
        XCTAssertEqual(fileNotebook.notes.count, 0)
    }
    func testNoteSaveToFile() {
        fileNotebook.add(noteToAdd: note)
        fileNotebook.saveNotebookToFile()
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Notes.json")
        let jsData = try! String(contentsOf: path)
        print(jsData)
        
        XCTAssertTrue(jsData.contains("\"uid\":\"42\""))
        
    }
    func testNoteLoadFromFile() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Notes.json")
        
        let jsData = try! JSONSerialization.data(withJSONObject: [note.json], options: [])
        try! jsData.write(to: path)
        
        fileNotebook.loadNotebookFromFile()
        
        XCTAssertEqual(fileNotebook.notes.count, 1)
        XCTAssertEqual(fileNotebook.notes[0].uid, "42")
        
    }
    func testCreatedPath() {
        fileNotebook.saveNotebookToFile()
        
        XCTAssertNotNil(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Notes.json"))
    }

}
