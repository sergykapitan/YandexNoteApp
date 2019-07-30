//
//  imageCell.swift
//  TestApp
//
//  Created by Sergey Koriukin on 20/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import Foundation
import UIKit


class ImageCell: UICollectionViewCell {
    
    
    @IBOutlet var image: UIImageView!
        override func awakeFromNib() {
            super.awakeFromNib()
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 1
    }
    
    
}
