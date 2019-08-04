//
//  SaveNoteDBOperation.swift
//  TestApp
//
//  Created by Sergey Koriukin on 02/08/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import CocoaLumberjack

class SaveNoteDBOperation: BaseDBOperation {
    
    private let note: Note
    
    init(note: Note,
         notebook: FileNotebook) {
        self.note = note
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.add(noteToAdd: note)
       // notebook.add(note: note)
       // notebook.saveToFile()
        notebook.saveNotebookToFile()
        
        DDLogDebug("Save notes to db completed")
        
        finish()
    }
}
