//
//  SettingsViewController.swift
//  SharePhoto
//
//  Created by Harun on 17.06.2021.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var allUsersTotalPost: UILabel!
    @IBOutlet weak var userTotalPost: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTotalTexts: UILabel!
    @IBOutlet weak var allUsersTotalTexts: UILabel!
    var userArray = [String]()
    var userTextArray = [String]()
    var urTotalPost = 0
    var urTotalText = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        let username = Auth.auth().currentUser?.email
        let components = username?.components(separatedBy: "@")
        usernameLabel.text = "Username : \(components![0])"
        self.userProfilePicture.image = UIImage(named: "avatar")
        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    
    // Profile Menüsüne her girildiğinde çalışacak olan komut
    override func viewWillAppear(_ animated: Bool) {
        let firebaseDatabase = Firestore.firestore()
        // Post Sayıları İşlemi
        firebaseDatabase.collection("Post").getDocuments { QuerySnapshot, error in
            if error != nil {
                print("Hata Bulundu!")
            }else{
               self.urTotalPost = 0
                for document in QuerySnapshot!.documents {
                    for doc in document.data(){
                        self.userArray.removeAll(keepingCapacity: false)
                        if doc.key == "email" {
                            self.userArray.append(doc.value as! String)
                            for user in self.userArray {
                                if user == Auth.auth().currentUser?.email {
                                    self.urTotalPost+=1
                                }
                            }
                            
                        }
                    }
                }
                self.allUsersTotalPost.text = "Total Post : \(QuerySnapshot!.count)"
                self.userTotalPost.text = "Ur Total Post : \(self.urTotalPost)"
            }
        }
        // Text Sayıları İşlemi
        firebaseDatabase.collection("Text").getDocuments { QuerySnapshot, error in
            if error != nil {
                print("Hata Bulundu!")
            }else{
               self.urTotalText = 0
                let str = Auth.auth().currentUser?.email
                let components = str?.components(separatedBy: "@")
                for document in QuerySnapshot!.documents {
                    for doc in document.data(){
                        self.userTextArray.removeAll(keepingCapacity: false)
                        if doc.key == "userName" {
                            self.userTextArray.append(doc.value as! String)
                            for user in self.userTextArray {
                                if user == components![0] {
                                    self.urTotalText+=1
                                }
                            }
                            
                        }
                    }
                }
                self.allUsersTotalTexts.text = "Total Texts : \(QuerySnapshot!.count)"
                self.userTotalTexts.text = "Ur Total Texts : \(self.urTotalText)"
            }
        }
    }

    
    // Çıkış Yap Fonksiyonu
    @IBAction func clickedLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("Hata")
        }
    }
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
