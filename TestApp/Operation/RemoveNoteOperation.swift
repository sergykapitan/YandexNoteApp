//
//  RemoveNoteOperation.swift
//  TestApp
//
//  Created by Sergey Koriukin on 02/08/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import CocoaLumberjack

class RemoveNoteOperation: AsyncOperation {
    
    private let noteId: String
    private var saveToBackend: SaveNotesBackendOperation
    private let removeFromDb: RemoveNoteDBOperation
    
    init(noteId: String,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {
        
        self.noteId = noteId
        
        removeFromDb = RemoveNoteDBOperation(noteId: noteId, notebook: notebook)
        saveToBackend = SaveNotesBackendOperation(notes: notebook.notes)
        
        super.init()
        
        removeFromDb.completionBlock = {
            backendQueue.addOperation(self.saveToBackend)
        }
        
        addDependency(removeFromDb)
        addDependency(saveToBackend)
        
        dbQueue.addOperation(removeFromDb)
    }
    
    override func main() {
        DDLogDebug("Deleted note with ID \(noteId)")
        
        finish()
    }
}
