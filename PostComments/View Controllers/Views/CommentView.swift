//
//  CommentView.swift
//  PostComments
//
//  Created by C4Q on 1/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class Line: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CommentView: UIView {

    lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "c4q-logo")
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Arial", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var upVote: UIButton = {
        let button = UIButton()
        button.setTitle("👍🏽", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var numVotes: UILabel = {
        let label = UILabel()
        label.text = "# 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var downVote: UIButton = {
        let button = UIButton()
        button.setTitle("👎🏽", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var voteStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.horizontal
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = .center
        stView.spacing = 8.0
        return stView
    }()
    
    lazy var numComments: UILabel = {
        let label = UILabel()
        label.text = "0 comment(s)"
        label.textAlignment = .center
        return label
    }()
    
    lazy var newComment: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoComment"), for: .normal)
        return button
    }()
    
    lazy var headerL2: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.horizontal
        stView.distribution  = UIStackViewDistribution.fillEqually
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 8.0
        return stView
    }()
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 1.5
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "mrugama")
        return image
    }()
    
    lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text your comment..."
        return textField
    }()
    
    lazy var commentStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.horizontal
        stView.distribution  = UIStackViewDistribution.fillProportionally
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 32.0
        return stView
    }()
    
    lazy var headerStackView: UIStackView = {
        let stView = UIStackView()
        stView.axis  = UILayoutConstraintAxis.vertical
        stView.distribution  = UIStackViewDistribution.fill
        stView.alignment = UIStackViewAlignment.center
        stView.spacing   = 8.0
        return stView
    }()
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(headerStackView)
        headerStackView.addArrangedSubview(postImageView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(headerL2)
        headerL2.addArrangedSubview(voteStackView)
        voteStackView.addArrangedSubview(upVote)
        voteStackView.addArrangedSubview(numVotes)
        voteStackView.addArrangedSubview(downVote)
        headerL2.addArrangedSubview(numComments)
        headerL2.addArrangedSubview(newComment)
        headerStackView.addArrangedSubview(commentStackView)
        commentStackView.addArrangedSubview(profileImageView)
        commentStackView.addArrangedSubview(commentTextField)
        addSubview(tableView)
        constraints()
    }
    
    private func constraints() {
        headerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        commentStackView.snp.makeConstraints { (make) in
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.bottom.equalTo(headerStackView.snp.bottom).offset(-8)
            //make.width.equalTo(headerStackView.snp.width)
            //make.height.equalTo(40)
        }
        profileImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.left.equalTo(self.snp.left).offset(16)
            //make.centerY.equalTo(commentStackView.snp.centerY)
        }
        commentTextField.snp.makeConstraints { (make) in
            make.left.equalTo(profileImageView.snp.right).offset(16)
            make.right.equalTo(commentStackView.snp.right)
        }
        headerL2.snp.makeConstraints { (make) in
            make.width.equalTo(headerStackView.snp.width)
            make.centerX.equalTo(headerStackView.snp.centerX)
            make.height.equalTo(32)
            make.bottom.equalTo(commentStackView.snp.top).offset(-8)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(headerStackView.snp.width)
            make.bottom.equalTo(headerL2.snp.top)
        }
        postImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLabel.snp.top)
            make.width.equalTo(headerStackView.snp.width)
            make.top.equalTo(headerStackView.snp.top)
            make.centerX.equalTo(headerStackView.snp.centerX)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerStackView.snp.bottom).offset(32)
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
    }
    
}
