//
//  TableViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 12/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
   //MARK: Property
    var notebook = FileNotebook.shared
    var note: Note?
  
    //MARK: Outlets
    @IBOutlet var noteTableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.rowHeight = UITableView.automaticDimension
        noteTableView.estimatedRowHeight = 600
        navigationItem()
        notebook.loadNotebookFromFile()
        checkEmpty()
        noteTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        guard note != nil else { return }
        notebook.add(noteToAdd: note!)
        
    }
    //MARK: Navigation
    func navigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tableViewEditing(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addNewNote(_:)))
    }
  
    @objc func addNewNote(_ sender: Any) {
        performSegue(withIdentifier: "SegueNoteAdd", sender: nil)
    }
    //MARK: TableViewEditing
    @objc func tableViewEditing(_ sender: Any) {
        if noteTableView.isEditing == false {
            noteTableView.isEditing = true
            noteTableView.reloadData()
        } else {
            noteTableView.isEditing = false
            noteTableView.reloadData()
        }
       
        
    }
    private func checkEmpty() {
        if notebook.notes.isEmpty {
        noteTableView.emptyList(true, "", noteTableView.frame.height / 3)
           print("notes is empty")
        }
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        notebook.saveNotebookToFile()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let viewController = segue.destination as? ViewController {
        
        viewController.onDone = { [weak self] in self?.notebook.add(noteToAdd: $0);
            self?.noteTableView.emptyList(false);
            self?.noteTableView.reloadData()
                                               }
                 viewController.note = sender as? Note ?? viewController.note
                 noteTableView.reloadData()
            }
        }
    
}


//MARK: UITableViewDelegate, UITableViewDataSource

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notebook.notes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
       
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//        let maskPathTop = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5.0, height: 5.0))
//        let shapeLayerTop = CAShapeLayer()
//        shapeLayerTop.frame = cell.bounds
//        shapeLayerTop.path = maskPathTop.cgPath
//        cell.layer.cornerRadius = 10
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 2
 //       cell.layer.mask = shapeLayerTop
  //      cell.layer.cornerRadius = 10
  //      let shadowPath2 = UIBezierPath(rect: cell.bounds)
  //      cell.layer.masksToBounds = false
  //      cell.layer.shadowColor = UIColor.black.cgColor
     //   cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.shadowPath = shadowPath2.cgPath
        cell.textLabel?.text = notebook.notes[indexPath.section].title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = notebook.notes[indexPath.section].content
        cell.detailTextLabel?.numberOfLines = 5
        cell.imageView?.image = UIImage(named: "fon")
        cell.imageView?.backgroundColor = notebook.notes[indexPath.section].color
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return noteTableView.isEditing
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return notebook.notes[section].importance.rawValue
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueEditNote", sender: notebook.notes[indexPath.section])
    }
   
   
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let autoDestroyDate = Date(timeInterval: 60 * 60 * 24 * 10, since: Date())
        let date = notebook.notes[section].destroyDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let todaysDate = dateFormatter.string(from: date ?? autoDestroyDate)
        return todaysDate
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexpath) in
            let uid = self.notebook.notes[indexpath.section].uid
            self.notebook.remove(with: uid)
            self.noteTableView.reloadData()
        }
        editButton.backgroundColor = .red
        let cancelButton = UITableViewRowAction(style: .normal, title: "Cancel") { (rowAction, indexpath) in
            self.noteTableView.reloadData()
        }
        cancelButton.backgroundColor = .gray
        return[editButton, cancelButton]
    }
    
}
