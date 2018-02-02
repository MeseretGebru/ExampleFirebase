//
//  CommentVC.swift
//  PostComments
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SnapKit

class CommentVC: UIViewController {

    var comments = [Comment]() {
        didSet {
            commentView.tableView.reloadData()
            commentView.numComments.text = "\(self.comments.count) comment(s)"
        }
    }
    
    var post: Post!
    let commentView = CommentView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addComment))
        viewContraints()
        loadData()
        view.backgroundColor = .white
        commentView.tableView.delegate = self
        commentView.tableView.dataSource = self
    }
    
    private func viewContraints() {
        view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    private func loadData() {
        commentView.titleLabel.text = post.postContent
        //print(self.post.ref!)
        let postRef = self.post.ref!.child("comments")
        postRef.observe(.value) { (snapShot) in
            var comments = [Comment]()
            for comment in snapShot.children {
                let newComment = Comment(snapShot: comment as! DataSnapshot)
                comments.append(newComment)
            }
            self.comments = comments
        }
        commentView.tableView.delegate = self
        commentView.tableView.dataSource = self
    }
    
    @objc private func addComment() {
        let newPost = UIAlertController(title: "New Comment", message: "Please write your comment", preferredStyle: .alert)
        newPost.addTextField { (textField) in
            textField.placeholder = "New Comment"
        }
        newPost.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        newPost.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let message = newPost.textFields?.first?.text {
                self.saveComment(text: message)
            }
        }))
        present(newPost, animated: true, completion: nil)
    }
    
    private func saveComment(text: String) {
        guard let id = self.post.ref?.child("comments").childByAutoId() else {return}
        
        let post = Post(postId: id.key, postImageStringUrl: "No post image so far", userImageStringUrl: "No image so far", content: text, userName: "User1")
        
        id.setValue(post.toAnyObject())
        self.loadData()
    }
}


