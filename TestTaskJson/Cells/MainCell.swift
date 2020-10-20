//
//  MainCell.swift
//  TestTaskJson
//
//  Created by Roma on 10/19/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let arrowImageView = UIImageView()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell() {
        self.contentView.addSubview(mainLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(arrowImageView)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        
        
        arrowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        arrowImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        arrowImageView.image = UIImage(named: "tableArrow")?.withTintColor(.lightGray)
        
        descriptionLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: arrowImageView.rightAnchor, constant: -30).isActive = true
        descriptionLabel.textColor = .lightGray
    }
    
    func deleteArrow() {
        arrowImageView.isHidden = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
    }

}
