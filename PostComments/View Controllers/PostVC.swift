//
//  ViewController.swift
//  PostComments
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class PostVC: UIViewController {

    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configurationBar()
        loadData()
        view.backgroundColor = .orange
        viewConstrainsts()
    }
    
    private func configurationBar() {
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.tintColor = .white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            //UIFont(name: "Arial", size: 32)
        
        titleLabel.text = "Post"
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addPost))
    }
    
    private func viewConstrainsts() {
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    private func loadData() {
        let postRef = Database.database().reference().child("posts")
        postRef.observe(.value) { (snapShot) in
            var posts = [Post]()
            for post in snapShot.children {
                let newPost = Post(snapShot: post as! DataSnapshot)
                posts.insert(newPost, at: 0)
            }
            self.posts = posts
        }
    }
    
    @objc private func addPost() {
        let newPost = UIAlertController(title: "New Post", message: "Please write your post", preferredStyle: .alert)
        newPost.addTextField { (textField) in
            textField.placeholder = "New post"
        }
        newPost.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        newPost.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let message = newPost.textFields?.first?.text {
                self.savePost(text: message)
            }
        }))
        present(newPost, animated: true, completion: nil)
    }
    
    private func savePost(text: String) {
        let id = Database.database().reference().child("posts").childByAutoId()
        let post = Post(postId: id.key, postImageStringUrl: "No post image so far", userImageStringUrl: "No user image so far", content: text, userName: "User1")
        id.setValue(post.toAnyObject())
        self.loadData()
    }
}

extension PostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let commentVC = CommentVC()
        commentVC.post = post
        navigationController?.pushViewController(commentVC, animated: true)
    }
}

extension PostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.postContent
        cell.detailTextLabel?.text = "User1"
        return cell
    }
}

