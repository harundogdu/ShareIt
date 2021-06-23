//
//  TextViewController.swift
//  SharePhoto
//
//  Created by Harun on 19.06.2021.
//

import UIKit
import Firebase

class TextViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // tanımlamalar
    @IBOutlet weak var tableView: UITableView!
    var TextArray = [Text]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        showPosts()
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action:#selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // Text Ekranının Yüklenme sırasında çalışacak olan textleri gösteren fonksiyon
    func showPosts(){
        let FirebaseDatabase = Firestore.firestore()
        FirebaseDatabase.collection("Text").order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
            
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if querySnapshot?.isEmpty != true && querySnapshot != nil {
                    self.TextArray.removeAll(keepingCapacity: false)
                    for document in querySnapshot!.documents {
                        
                        if let userName = document.get("userName") as? String {
                                if let userText = document.get("userText") as? String {
                                    let text = Text(userText: userText, userName: userName)
                                    self.TextArray.append(text)
                                }
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.TextArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableCell", for: indexPath) as! TextTableViewCell
        cell.userTextLabel!.text = self.TextArray[indexPath.row].userText
        cell.userUserNameLabel!.text = self.TextArray[indexPath.row].userName
        return cell
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
