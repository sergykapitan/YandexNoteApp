//
//  ColorPikerViewController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 16/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit

protocol ColorPikerViewControllerDelegate
{
    func callback(_ sender: UIColor)
}


class ColorPikerViewController: UIViewController {
  
    //MARK: - Outlets

    @IBOutlet var navigationImage: UIImageView!
    @IBOutlet var colorSelectedView: UIView!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var brigthnesSlider: UISlider!
    @IBOutlet var colorPalletView: ColorPaletteView!
    @IBOutlet var doneButton: UIButton!
    
     // output color value

    @IBInspectable var selectedColor: UIColor = .white
    @IBInspectable var selectedColorBrightness: Float {
        get {
            return brigthnesSlider.value
        }
        set {
            brigthnesSlider.value = newValue
            updateUI()
        }
    }
    
    private var pickedFromPaletteColor: UIColor = .white {
        didSet {
            updateUI()
        }
    }
     var color: UIColor?
     var doneBtnHandler: (() -> Void)?
     var delegate: ColorPikerViewControllerDelegate?
    
    //MARK: - Action
    @IBAction func brigthesAction(_ sender: UISlider) {
        doneBtnHandler?()
        selectedColorBrightness = sender.value
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        color = selectedColor
        delegate?.callback(selectedColor)
        navigationController?.popViewController(animated: true)
    }
    
    // TODO: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationItem()
       // set color picker view params
        colorSelectedView.layer.borderWidth = 2
        colorSelectedView.layer.borderColor = UIColor.black.cgColor
        colorSelectedView.layer.cornerRadius = 5
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    private func updateUI() {
        // accept current brightness value to new color
        selectedColor = UIColor(hue: pickedFromPaletteColor.hue.hue, saturation: pickedFromPaletteColor.hue.saturation, brightness: CGFloat(selectedColorBrightness), alpha: pickedFromPaletteColor.hue.alpha)
        colorSelectedView.backgroundColor = selectedColor
        color = selectedColor
        colorLabel.text = selectedColor.toHexString()
    }
    private func colorPaletteViewTapped(_ point: CGPoint, _ color: UIColor) {
        navigationImage.center = point
        pickedFromPaletteColor = color
    }

    private func setupViews() {

        self.colorPalletView.colorPaletteTappedHandler = { [weak self] (_ point: CGPoint, _ color: UIColor) in
            self?.colorPaletteViewTapped(point, color)
        }
        // set cursor to default
        navigationImage.center = CGPoint(x: 0, y: 0)
        // update view with default values at first time
        updateUI()
    }
   
    
    // MARK: - Navigation
    func navigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сancel", style: .plain, target: self, action: #selector(dontSelectedColor(_:)))
    }
     @objc func dontSelectedColor(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }


}
