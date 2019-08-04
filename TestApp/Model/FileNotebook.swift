//
//  FileNotebook.swift
//  Note
//
//  Created by Sergey Koriukin on 24/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import CocoaLumberjack

class FileNotebook{
    
     public private(set) var notes: [Note] = []
     static var shared = FileNotebook()
    
     var readNotes: [Note] { return self.notes }
    
    
    public func add(noteToAdd note:Note) {
        if let itm = notes.firstIndex(where: { $0.uid == note.uid})  {
            notes[itm] = note
         //   print("Note already exist")
            
            return
        } else {
        notes.append(note)
        }
        
    }
    public func replaceAll(notes: [Note]) {
        self.notes = notes
    }
    
    public func remove(with uid: String) {
        if let index: Int = notes.firstIndex(where: {$0.uid == uid}) {
            notes.remove(at: index)
        }
    }
    
    public func saveNotebookToFile() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Notes.json")
        
        let notesArray = notes.map{$0.json}
        
        do {
            let data = try JSONSerialization.data(withJSONObject: notesArray, options: [])
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }
    
    public func loadNotebookFromFile(){
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("Notes.json")
        
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let notesArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else { return }
            notes = notesArray.map {
                Note.parse(json: $0)!
            }
        } catch {
            print(error)
        }
    }
    
}
