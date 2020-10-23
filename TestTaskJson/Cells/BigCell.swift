//
//  bigCell.swift
//  TestTaskJson
//
//  Created by Roma on 10/19/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class BigCell: UITableViewCell {
    
    //MARK: - Variables and Constants
    let view = UIView()
    var arrayOfImageUrls = [String]()
    var viewPhotos: UICollectionView!
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.actions, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let labelPrice: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelYear: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelMileage: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelZipCode: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelHistory: UILabel = {
        let label = UILabel()
        label.text = "History not avaible"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .lightGray
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layoutTmp = UICollectionViewFlowLayout()
        layoutTmp.scrollDirection = .horizontal
        layoutTmp.minimumLineSpacing = 0
        return layoutTmp
    }()
    
    //MARK: - Methods (UI Part)
    func setupCell(object: Object?) {
        
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        layout.itemSize = CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height / 2)

        viewPhotos = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        viewPhotos.showsHorizontalScrollIndicator = true
        viewPhotos.indicatorStyle = .white
        viewPhotos.isPagingEnabled = true
        viewPhotos.backgroundColor = .white
        viewPhotos.translatesAutoresizingMaskIntoConstraints = false
          
        viewPhotos.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewID")
        viewPhotos.collectionViewLayout = layout
        viewPhotos.dataSource = self
        	
        
        self.contentView.addSubview(viewPhotos)
        viewPhotos.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        viewPhotos.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        viewPhotos.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        viewPhotos.bottomAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
      
        view.addSubview(labelPrice)
        labelPrice.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 18).isActive = true
        labelPrice.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18).isActive = true
       
        
        view.addSubview(shareButton)
        
        shareButton.topAnchor.constraint(equalTo: labelPrice.topAnchor).isActive = true
        shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18).isActive = true
        
        
        view.addSubview(labelTitle)
        
        labelTitle.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 18).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: labelPrice.leftAnchor).isActive = true
       
        
        view.addSubview(labelYear)
        
        labelYear.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10).isActive = true
        labelYear.leftAnchor.constraint(equalTo: labelTitle.leftAnchor).isActive = true
        labelYear.widthAnchor.constraint(equalToConstant: 45).isActive = true
        labelYear.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        view.addSubview(labelMileage)
        
        labelMileage.centerYAnchor.constraint(equalTo: labelYear.centerYAnchor).isActive = true
        labelMileage.leftAnchor.constraint(equalTo: labelYear.rightAnchor, constant: 10).isActive = true
        
        view.addSubview(labelZipCode)
        
        labelZipCode.centerYAnchor.constraint(equalTo: labelYear.centerYAnchor).isActive = true
        labelZipCode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        
        view.addSubview(labelHistory)
        
        labelHistory.topAnchor.constraint(equalTo: labelYear.bottomAnchor, constant: 10).isActive = true
        labelHistory.leftAnchor.constraint(equalTo: labelYear.leftAnchor).isActive = true
        labelHistory.heightAnchor.constraint(equalToConstant: 22).isActive = true
        labelHistory.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        
        
        self.fetchImageUrls(arrayOfImageUrls: object!.images)
        self.labelPrice.text = "$\(object?.price ?? 0)"
        self.createAttributedTitle(object: object, label: self.labelTitle)
        self.labelYear.text = "\(object?.year ?? 0)"
        self.labelMileage.text = "\(object?.mileage ?? 0) miles"
        self.labelZipCode.text = "\(object?.addresses[0].zipcode ?? "No Zip Code")"
    }
    
    //MARK: - Methods (Logic Part)
    func fetchImageUrls(arrayOfImageUrls: [Object.Images]) {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in arrayOfImageUrls {
                if (i.url != nil) {
                    if (!self.arrayOfImageUrls.contains(i.url!)) {
                        self.arrayOfImageUrls.append(i.url!)
                    }
                } else if (i.uri != nil) {
                    if (!self.arrayOfImageUrls.contains(i.uri!)) {
                        self.arrayOfImageUrls.append(i.uri!)
                    }
                }
            }
            DispatchQueue.main.async {
                self.viewPhotos.reloadData()
            }
        }
    }
    
    func createAttributedTitle(object: Object?, label: UILabel) {
           let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 19)]
           let lightAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
           let firstString = NSMutableAttributedString(string:"\(object?.make ?? "no make") ", attributes:attrs)
           let secondString = NSMutableAttributedString(string:"\(object?.model ?? "no model") ", attributes:attrs)
           let thirdString = NSMutableAttributedString(string:object?.trim ?? "no trim", attributes:lightAttrs)
           firstString.append(secondString)
           firstString.append(thirdString)
           label.attributedText = firstString
       }
    
    //MARK: - Others
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK: - UICollectionViewDataSource
extension BigCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .white
        cell.setupCell(url: arrayOfImageUrls[indexPath.row])
        cell.imageView.image = UIImage(named: "carPlaceholder")
        Downloader().downloadImage(from: URL(string: arrayOfImageUrls[indexPath.row])!, completion: { (image, url) in
            if url.absoluteString == cell.imageUrl! {
                cell.imageView.image = image
            }
        })
        
        return cell
    }
}
