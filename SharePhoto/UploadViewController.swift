//
//  UploadViewController.swift
//  SharePhoto
//
//  Created by Harun on 17.06.2021.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    // Upload Butonu Fonksiyonu
    @IBAction func clickedUpload(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            
            imageRef.putData(data, metadata: nil) { (StorageMetaData, error) in
                if error != nil {
                    self.errorMessage(inputTitle: "Hata!", inputText: error?.localizedDescription ?? "Fotoğraf Yüklenirken Bir Hata Oluştu!")
                }else {
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            if let imageURL = imageURL {
                                let FirebaseDatabase = Firestore.firestore()
                                let postData = [
                                    "email" : Auth.auth().currentUser!.email,
                                    "imageURL" : imageURL,
                                    "comment" : self.commentTextField.text!,
                                    "date" : FieldValue.serverTimestamp()
                                ] as [String : Any]
                                
                                FirebaseDatabase.collection("Post").addDocument(data: postData)
                                { (error) in
                                    if error != nil {
                                        self.errorMessage(inputTitle: "Hata!", inputText: error?.localizedDescription ?? "Paylaşma Sırasında Bir Sorun Oluştu, Daha Sonra Tekrar Deneyiniz!")
                                    }else{
                                        self.imageView.image = UIImage.init(named: "upload")
                                        self.commentTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }
                    }
                } // else end
            }
        }
    }
    
    // Resim Seçme Fonksiyonu
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    // Resmi ekrana basma Fonksiyonu
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    // Hata Mesajı Göster
    func errorMessage(inputTitle : String , inputText : String) {
        let alert = UIAlertController(title: inputTitle, message: inputText, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    

}
