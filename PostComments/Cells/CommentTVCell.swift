//
//  CommentTVCell.swift
//  PostComments
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CommentTVCell: UITableViewCell {

    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "mrugama")
        return image
    }()
    
    lazy var commentTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func configureCell(image: UIImage?, message: String){
        if let image = image {
            profileImageView.image = image
        }
        commentTextLabel.text = message
    }
    
    private func commonInit() {
        addSubview(profileImageView)
        //addSubview(commentTextLabel)
        
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.left.equalTo(self.snp.left).offset(32)
            make.centerY.equalTo(self.snp.centerY)
        }
        
//        commentTextLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(profileImageView.snp.right).offset(32)
//            make.right.equalTo(self.snp.right).offset(-32)
//            make.height.equalTo(self.snp.height)
//            make.centerY.equalTo(self.snp.centerY)
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

}
