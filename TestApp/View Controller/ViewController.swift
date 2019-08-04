//
//  ViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 24/06/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit
import CocoaLumberjack
import IQKeyboardManagerSwift



class ViewController: UIViewController, UITextViewDelegate {
    
 
    
    //MARK: Outlets
    
    @IBOutlet var greenColorView: UIIntroductionView!
    @IBOutlet var palletColorView: UIIntroductionView!
    @IBOutlet var redColorView: UIIntroductionView!
    @IBOutlet var whitheColorView: UIIntroductionView!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var switchDatePicker: UISwitch!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var hightTextView: NSLayoutConstraint!
    
  
    //MARK: - Property
    var showB = true
    var showC = true
    var color: UIColor? //= .white
    var onDone: ((Note) -> ())?
    var note: Note = Note(title: "", content: "", importance: .normal, destroyDate: nil)
    let uuid = UUID().uuidString
    var myColor: UIColor?
   
    //TODO: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        color = myColor
        tapRecognizer()
        
    }
   
    func configure() {
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.backgroundColor = UIColor.lightGray
        textView.text = note.content
        titleTextField.text = note.title
        if myColor == nil {
            guard note.color == UIColor.white else { return myColor = note.color }
           
        }
    }
    
    //MARK: - Tap&LongRecognizer
    func tapRecognizer() {
        
        if color == nil {
        palletColorView.isPaletteBox = true
        // set default white box
        whitheColorView.isSelectedBox = true
        // add one tap recognizer to 1-3 boxes
        for colorBox in [whitheColorView, redColorView, greenColorView] {
            let oneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ColorBoxOneTapHandler))
            oneTapRecognizer.numberOfTapsRequired = 1
            colorBox?.addGestureRecognizer(oneTapRecognizer)}
         } else {
        palletColorView.isPaletteBox = false
        whitheColorView.isSelectedBox = false
        redColorView.isSelectedBox = false
        greenColorView.isSelectedBox = false
        // set default pallet box
        palletColorView.selectedColor = color!
        //  add one tap reconizer to 1-4 boxes
        palletColorView.isSelectedBox = true
        for colorBox in [whitheColorView, redColorView, greenColorView, palletColorView] {
            let oneTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ColorBoxOneTapHandler))
            oneTapRecognizer.numberOfTapsRequired = 1
            colorBox?.addGestureRecognizer(oneTapRecognizer)}
        
        
        }
        
        // add long tap recognizer to 4 box
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(PaletteBoxLongTapHandler))
        palletColorView.addGestureRecognizer(longPressRecognizer)
        
        
       
    }
    
    @objc func ColorBoxOneTapHandler(recognizer: UITapGestureRecognizer) {
        guard let tappedBox = recognizer.view as? UIIntroductionView else { return }
        // check already selected color box
        guard !tappedBox.isSelectedBox else { return }
        ChangeColorBoxesStates(tappedBox.tag)
        color = tappedBox.selectedColor
    }
    @objc func PaletteBoxLongTapHandler(recognizer: UILongPressGestureRecognizer) {
        guard (recognizer.view as? UIIntroductionView) != nil else { return }
        guard recognizer.state == .began else { return }
        let colorPikerViewController = ColorPikerViewController()
        colorPikerViewController.delegate = self
        performSegue(withIdentifier: "SeguePikerColor", sender: nil)
        
    }
    
//    private func saveNote() {
//
//        guard let editedNote = Note(uid: note.uid, title: titleTextField.text ?? "", content: textView.text ?? "", color: color ?? UIColor.white, importance: .normal, destroyDate: switchDatePicker.isOn ? datePicker.date : nil) else {
//            return
//        }
//
//        let saveNoteOperation = SaveNoteOperation(note: editedNote, notebook: AppDelegate.noteBook, backendQueue: OperationQueue(), dbQueue: OperationQueue())
//
//        saveNoteOperation.completionBlock = {
//            OperationQueue.main.addOperation {
//                DDLogDebug("Return to the list of notes")
//
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//
//        OperationQueue().addOperation(saveNoteOperation)
//    }
//
    //MARK: - Navigation
    
    func navigationItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dontSaveNote(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNote(_:)))
    }
    @objc func dontSaveNote(_ sender: Any) { //SegueCancel
       performSegue(withIdentifier: "SegueCancel", sender: nil)
    }
   
    @objc func saveNote(_ sender: Any) {
        performSegue(withIdentifier: "SegueTableView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueTableView" {
             if let tableViewController = segue.destination as? TableViewController {
                
                 let editedNote = Note(uid: note.uid, title: titleTextField.text ?? "", content: textView.text ?? "", color: color ?? UIColor.white, importance: .normal, destroyDate: switchDatePicker.isOn ? datePicker.date : nil)
                 let saveNoteOperation = SaveNoteOperation(note: editedNote, notebook: AppDelegate.noteBook, backendQueue: OperationQueue(), dbQueue: OperationQueue())
                saveNoteOperation.completionBlock = {
                    OperationQueue.main.addOperation {
                        DDLogDebug("Return to the list of notes")
                        
                        //self.navigationController?.popViewController(animated: true)
                    }
                }
                
                OperationQueue().addOperation(saveNoteOperation)
                
                
                
                
                
//                note = Note(uid: note.uid, title: titleTextField.text ?? "", content: textView.text ?? "", color: color ?? UIColor.white, importance: .normal, destroyDate: switchDatePicker.isOn ? datePicker.date : nil)
//
//                    onDone?(note)
//                    tableViewController.note = note
            }
        }
        if segue.identifier == "SeguePikerColor"{
            let scp: ColorPikerViewController = segue.destination as! ColorPikerViewController
                scp.delegate = self

       }
        if segue.identifier == "SegueCancel" {
            if let tableViewController = segue.destination as? TableViewController {
                tableViewController.note = nil
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        hightTextView.constant = textView.frame.height
        
        return true
    }

    private func ChangeColorBoxesStates(_ tag: Int) {
        // reset flags
        for colorBox in [whitheColorView, redColorView, greenColorView, palletColorView] {
            if colorBox?.tag == tag {
                colorBox?.isSelectedBox = true
            } else {
                colorBox?.isSelectedBox = false
            }
        }
    }
    // redraw graphics after orientation changed
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        for colorBox in [whitheColorView, redColorView, greenColorView, palletColorView] {
            colorBox?.setNeedsDisplay()
        }
    }
}

extension ViewController: ColorPikerViewControllerDelegate{
    func callback(_ sender: UIColor) {
       myColor = sender
    }
    

   
    @IBAction func SwitchDatePicker(_ sender: Any) {
        showB = !showB
        UIView.animate(withDuration: 0.8){
            self.datePicker.isHidden = !self.showB
        }
  }
}
