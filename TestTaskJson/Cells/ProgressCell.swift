//
//  ProgressCell.swift
//  TestTaskJson
//
//  Created by Roma on 10/19/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class ProgressCell: UITableViewCell {
    
    //MARK: - Variables and Constants
    let mainLabel = UILabel()
    let progressBar = UIProgressView()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Methods (UI Part)
    func setupCell(progress: Float, mainLabelText: String, descriptionLabelText: String) {
        
        self.contentView.addSubview(mainLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(progressBar)
    
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        
        mainLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20).isActive = true
        
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
        
        progressBar.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        progressBar.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15).isActive = true
        progressBar.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
        
        self.progressBar.progress = progress
        self.mainLabel.text = mainLabelText
        self.descriptionLabel.text = descriptionLabelText
    }

    //MARK: - Others
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
