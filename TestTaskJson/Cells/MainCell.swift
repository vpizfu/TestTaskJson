//
//  MainCell.swift
//  TestTaskJson
//
//  Created by Roma on 10/19/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    //MARK: - Variables and Constants
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let arrowImageView = UIImageView()
    var descriptionLabelRightAnchor = NSLayoutConstraint()
        
    //MARK: - Methods (UI Part)
    func setupCell(mainLabelText: String, descriptionLabelText: String) {
        
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
        descriptionLabel.textColor = .lightGray
        
        self.mainLabel.text = mainLabelText
               self.descriptionLabel.text = descriptionLabelText
               
               switch mainLabelText {
               case "Mileage":
                    self.removeArrow()
               case "Features":
                    self.addArrow()
                    self.descriptionLabel.textColor = .systemBlue
               default:
                    self.addArrow()
                    self.descriptionLabel.textColor = .lightGray
               }
    }
    
    func removeArrow() {
        arrowImageView.removeFromSuperview()
        descriptionLabelRightAnchor.isActive = false
        descriptionLabelRightAnchor = descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
        descriptionLabelRightAnchor.isActive = true
    }
    
    func addArrow() {
        descriptionLabelRightAnchor.isActive = false
        descriptionLabelRightAnchor = descriptionLabel.rightAnchor.constraint(equalTo: arrowImageView.rightAnchor, constant: -30)
        descriptionLabelRightAnchor.isActive = true
    }
    
    
    //MARK: - Others
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
