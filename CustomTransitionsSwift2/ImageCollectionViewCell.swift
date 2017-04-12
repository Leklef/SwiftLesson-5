//
//  ImageCollectionViewCell.swift
//  CustomTransitionsSwift2
//
//  Created by Ленар on 09.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

protocol DidSelectedCell {
    func presentVC(cell:ImageCollectionViewCell)
}

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    
    var delegate:DidSelectedCell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.catImageView.isUserInteractionEnabled = true
        self.catImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.delegate.presentVC(cell: self)
    }

}
