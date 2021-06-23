//
//  RegisterViewController.swift
//  SharePhoto
//
//  Created by Harun on 19.06.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    // tanımlamalar
    @IBOutlet weak var userMail: UITextField!
    @IBOutlet weak var userPP: UIImageView!
    @IBOutlet weak var userPassword: UITextField!    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    // Kayıt Ol Gönderimi
    @IBAction func clickedRegister(_ sender: Any) {
        
        if userMail.text != "" && userPassword.text != "" {
            // kayıt başlangıcı
            Auth.auth().createUser(withEmail: userMail.text!, password: userPassword.text!) { (authDataResult,error) in
                if error != nil {
                    self.errorMessage(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Bir Sorun ile Karşılaşıldı, Lütfen Daha Sonra Tekrar Deneyiniz!")
                }else{
                    self.performSegue(withIdentifier: "toFeedVCLast", sender: nil)
                }
            }
        }else {
            errorMessage(titleInput: "Hata!", messageInput: "Email ve Parola Giriniz!")
        }
    }
    
    // Hata mesajı fonksiyonu
    func errorMessage(titleInput: String , messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
