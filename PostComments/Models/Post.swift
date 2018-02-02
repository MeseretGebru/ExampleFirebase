//
//  Post.swift
//  PostComments
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct Post {
    var ref: DatabaseReference?
    var key: String!
    var postId: String
    var postImageStringUrl: String
    var userImageStringUrl: String
    var postContent: String
    var userName: String
    
    // preparing info to be saved into firebase
    init(postId: String, postImageStringUrl: String, userImageStringUrl: String, content: String, userName: String, key: String = ""){
        self.postContent = content
        self.postId = postId
        self.postImageStringUrl = postImageStringUrl
        self.userImageStringUrl = userImageStringUrl
        self.userName = userName
        self.ref = Database.database().reference()
    }
    
    // take info from firebase
    init(snapShot: DataSnapshot){
        let value = snapShot.value as? [String: Any]
        self.postContent = value?["content"] as? String ?? ""
        self.postId = value?["postId"] as? String ?? ""
        self.postImageStringUrl = value?["postImageStringUrl"] as? String ?? ""
        self.userName = value?["userName"] as? String ?? ""
        self.userImageStringUrl = value?["userImageStringUrl"] as? String ?? ""
        self.key = snapShot.key
        self.ref = snapShot.ref
        
    }
    
    // transform info previous to save
    func toAnyObject() -> [String: Any] {
        return ["userImageSgtringUrl": userImageStringUrl, "content": postContent, "username": userName, "postId": postId, "postImageStringUrl": postImageStringUrl]
    }
    
}
