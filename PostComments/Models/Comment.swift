//
//  Comment.swift
//  PostComments
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct Comment {
    var userImageStringUrl: String
    var postId: String
    var content: String
    var userName: String
    var ref: DatabaseReference?
    var key: String!
    
    init(postId: String, userImageStringUrl: String, content: String, userName: String, key: String = ""){
        self.content = content
        self.postId = postId
        self.userImageStringUrl = userImageStringUrl
        self.userName = userName
        self.ref = Database.database().reference()
    }
    
    init(snapShot: DataSnapshot){
        let value = snapShot.value as? [String: Any]
        self.content = value?["content"] as? String ?? ""
        self.postId = value?["postId"] as? String ?? ""
        self.userName = value?["userName"] as? String ?? ""
        self.userImageStringUrl = value?["userImageStringUrl"] as? String ?? ""
        self.key = snapShot.key
        self.ref = snapShot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return ["userImageSgtringUrl": userImageStringUrl, "content": content, "username": userName, "postId": postId]
    }
    
}
