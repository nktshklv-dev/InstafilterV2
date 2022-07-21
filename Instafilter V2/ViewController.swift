//
//  ViewController.swift
//  Instafilter V2
//
//  Created by Nikita  on 7/11/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Hey!"
        content.body = "It's time to filter some photos!"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        title = "CameraFilter"
        let menu = UIMenu(title: "", children: [
            UIAction(title: "Take a photo", image: UIImage(systemName: "camera"), handler: takePhoto),
            UIAction(title: "Choose photo", image: UIImage(systemName: "photo.on.rectangle.angled"), handler: choosePhoto)])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), menu: menu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
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
    
    @objc func shareTapped(){
        guard let image = (imageView.image?.jpegData(compressionQuality: 1)) else{
                   print("No image found ")
                   return
               }
               let ac = UIActivityViewController(activityItems: [image], applicationActivities: [])
               ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
               present(ac, animated: true, completion: nil)
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

