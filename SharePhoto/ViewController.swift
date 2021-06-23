//
//  ViewController.swift
//  SharePhoto
//
//  Created by Harun on 17.06.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    // tanımlamalar
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    // Kayıt Ol Butonu Fonksiyonu
    @IBAction func clickedRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "toRegisterVC", sender: nil)        
    }
    
    // Giriş Yap Butonu Fonksiyonu
    @IBAction func clickedLogin(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
            {
                (authDataResult,error) in
                if error != nil{
                    self.errorMessage(titleInput: "Hata!", messageInput: "Girdiğiniz parametrelere ait bir hesap bulunamadı!")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.errorMessage(titleInput: "Hata!", messageInput: "Email ve Parola Giriniz!")
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

