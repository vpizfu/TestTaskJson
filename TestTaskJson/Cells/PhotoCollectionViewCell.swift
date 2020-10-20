//
//  PhotoCollectionViewCell.swift
//  TestTaskJson
//
//  Created by Roma on 10/19/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    var imageUrl:String?
    func setupCell(url: String) {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.imageUrl = url
    }
}
