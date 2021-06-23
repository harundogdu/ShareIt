//
//  Post.swift
//  SharePhoto
//
//  Created by Harun on 18.06.2021.
//

import Foundation

class Post {
    var email : String
    var comment : String
    var imageURL : String
    
    init(email : String , comment : String , imageURL : String) {
        self.email = email
        self.comment = comment
        self.imageURL = imageURL
    }
}
