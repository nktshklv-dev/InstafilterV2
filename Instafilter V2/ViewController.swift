//
//  ViewController.swift
//  Instafilter V2
//
//  Created by Nikita  on 7/11/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CameraFilter"
        let menu = UIMenu(title: "", children: [
            UIAction(title: "Take a photo", image: UIImage(systemName: "camera"), handler: takePhoto),
            UIAction(title: "Choose photo", image: UIImage(systemName: "photo.on.rectangle.angled"), handler: choosePhoto)])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), menu: menu)
        
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? FilterViewController else {return}
        guard let image = imageView.image else {return}
        vc.image = image
    }
    
    func takePhoto(_ action: UIAction){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {return}
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSave(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    
    func choosePhoto(_ action: UIAction){
        let picker = UIImagePickerController()
        
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {return}
        imageView.image = image
    }
    
   
    
    
    
    @objc func imageSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
           if let error = error {
               let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(ac, animated: true, completion: nil)
           }
           else{
               let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photo library.", preferredStyle: .alert)
               ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(ac, animated: true, completion: nil)
           }
       }
       
    @IBAction func unwindToOne(_ sender: UIStoryboardSegue){
        
    }
}

