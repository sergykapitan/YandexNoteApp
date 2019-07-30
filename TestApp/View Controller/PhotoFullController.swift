//
//  PhotoFullController.swift
//  TestApp
//
//  Created by Sergey Koriukin on 21/07/2019.
//  Copyright © 2019 Sergey Koriukin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoFullViewCell"

class PhotoFullController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images = [UIImage?]()
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        collectionView.contentOffset.x = UIScreen.main.bounds.width * CGFloat(index)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
      //  return CGSize(width: view.frame.width, height:  view.frame.height)
    }


    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoFullViewCell
       // cell.layer.cornerRadius = 10
        cell.photo.image = images[indexPath.row]
    
        return cell
    }

   

}
