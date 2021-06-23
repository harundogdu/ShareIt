//
//  FeedViewController.swift
//  SharePhoto
//
//  Created by Harun on 17.06.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    /*
    var emailArray = [String]()
    var imageArray = [String]()
    var commentArray = [String]()
    */
    var postArray = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        showPosts()
    }
    // Feed Ekranının Yüklenme sırasında çalışacak olan postları gösteren fonksiyon
    func showPosts(){
        let FirebaseDatabase = Firestore.firestore()
        FirebaseDatabase.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { querySnapshot, error in
            
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if querySnapshot?.isEmpty != true && querySnapshot != nil {
                    /*self.commentArray.removeAll(keepingCapacity: false)
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    */
                    self.postArray.removeAll(keepingCapacity: false)
                    for document in querySnapshot!.documents {
                        
                        if let email = document.get("email") as? String {
                            if let imageURL = document.get("imageURL") as? String {
                                if let comment = document.get("comment") as? String {
                                    let post = Post(email: email, comment: comment, imageURL: imageURL)
                                    self.postArray.append(post)
                                }
                            }
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    /* Table View İşlemleri  */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        let str = self.postArray[indexPath.row].email
        let components = str.components(separatedBy: "@")
        cell.emailText.text = components[0]
        cell.commentText.text = self.postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageURL))
        return cell
        
    }
}
