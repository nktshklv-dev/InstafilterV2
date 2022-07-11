//
//  FilterViewController.swift
//  Instafilter V2
//
//  Created by Nikita  on 7/11/22.
//

import UIKit
import CoreImage

class FilterViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    @IBOutlet var currentFilterLabel: UILabel!
    var image: UIImage!
    var currentFilter: CIFilter!
    var context: CIContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")

    }
    
    
    @IBAction func showFilters(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIXRay", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIThermal", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIColorInvert", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGlassLozenge", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVortexDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPhotoEffectNoir", style: .default, handler: setFilter))
        
        
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let popoverController = ac.popoverPresentationController{
                popoverController.sourceView = sender
                popoverController.sourceRect = sender.bounds
            }
            
            present(ac, animated: true)
        
    }
    
    func setFilter(_ action: UIAlertAction){
        print(action.title!)
        guard image != nil else {return}
        guard let actionTitle = action.title else {return}
        currentFilterLabel.text = actionTitle
        currentFilter = CIFilter(name: actionTitle)
        let beginImage = CIImage(image: image)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing(){
        guard let outputImage = currentFilter.outputImage else {return}
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
                   currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
               }
               if inputKeys.contains(kCIInputRadiusKey){
                   currentFilter.setValue(intensity.value * 2000, forKey: kCIInputRadiusKey)
               }
               if inputKeys.contains(kCIInputScaleKey){
                   currentFilter.setValue(intensity.value * 1000, forKey: kCIInputIntensityKey)
               }
               if inputKeys.contains(kCIInputCenterKey){
                   currentFilter.setValue(CIVector(x: image.size.width / 2, y: image.size.height / 2), forKey: kCIInputCenterKey)
               }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
            let newImage = UIImage(cgImage: cgImage)
            image = newImage
            imageView.image = newImage
            
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ViewController else {return}
        vc.imageView.image = image
        
    }
    
    @IBAction func changedValue(_ sender: Any) {
        applyProcessing()
    }
    
}
