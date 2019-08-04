//
//  LoadNotesDBOperation.swift
//  TestApp
//
//  Created by Sergey Koriukin on 02/08/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import CocoaLumberjack

class LoadNotesDBOperation: BaseDBOperation {
    
    var result: [Note]?
    
    override init(notebook: FileNotebook) {
        super.init(notebook: notebook)
    }
    
    override func main() {
        notebook.loadNotebookFromFile()
       // notebook.loadFromFile()
        result = notebook.notes
        
        DDLogDebug("Load notes from db completed")
        
        finish()
    }
}
