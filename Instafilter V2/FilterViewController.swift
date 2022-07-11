//
//  FilterViewController.swift
//  Instafilter V2
//
//  Created by Nikita  on 7/11/22.
//

import UIKit

class FilterViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image

    }
    
    
    @IBAction func showFilters(_ sender: Any) {
        
    }
    
    @IBAction func applyButton(_ sender: Any) {
    }
    
    @IBAction func changedValue(_ sender: Any) {
    }
    
}
