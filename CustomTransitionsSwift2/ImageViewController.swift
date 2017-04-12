//
//  ImageViewController.swift
//  CustomTransitionsSwift2
//
//  Created by Ленар on 09.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    
    var image:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        catImageView.image = image
    }
    
    
    @IBAction func exitButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
