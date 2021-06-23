//
//  ShareTextViewController.swift
//  SharePhoto
//
//  Created by Harun on 20.06.2021.
//

import UIKit
import Firebase

class ShareTextViewController: UIViewController {
    @IBOutlet weak var userOpinionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Metin Paylaş Butonu Fonksiyonu
    @IBAction func clickedShareText(_ sender: Any) {
        let FirebaseDatabase = Firestore.firestore()
        let str = Auth.auth().currentUser?.email
        let components = str?.components(separatedBy: "@")
        let TextData = [
            "userText" : self.userOpinionTextField!.text,
            "userName" : components![0],
            "date" : FieldValue.serverTimestamp()
        ] as [String : Any]
        FirebaseDatabase.collection("Text").addDocument(data: TextData)
        { (error) in
            if error != nil {
                self.errorMessage(inputTitle: "Hata!", inputText: error?.localizedDescription ?? "Paylaşma Sırasında Bir Sorun Oluştu, Daha Sonra Tekrar Deneyiniz!")
            }else{
                self.userOpinionTextField.text = ""
                self.tabBarController?.selectedIndex = 1
            }
        }
    }
    
    // Hata Mesajı Göster
    func errorMessage(inputTitle : String , inputText : String) {
        let alert = UIAlertController(title: inputTitle, message: inputText, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction.init(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
