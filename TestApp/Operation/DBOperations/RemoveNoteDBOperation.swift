//
//  RemoveNoteDBOperation.swift
//  TestApp
//
//  Created by Sergey Koriukin on 02/08/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import CocoaLumberjack

class RemoveNoteDBOperation: BaseDBOperation {
    
    private let noteId: String
    
    init(noteId: String,
         notebook: FileNotebook) {
        self.noteId = noteId
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.remove(with: noteId)
        notebook.saveNotebookToFile()
       // notebook.saveToFile()
        
        DDLogDebug("Remove note from db completed")
        
        finish()
    }
}
