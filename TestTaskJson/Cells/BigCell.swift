//
//  bigCell.swift
//  TestTaskJson
//
//  Created by Roma on 10/19/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class BigCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
    let view = UIView()
    let additionalView = UIView()
    var arrayOfImageUrls = [String]()
    
    var numberOfPhotos = 0
    
    var viewPhotos: UICollectionView!
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.actions, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let labelTwo: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelThree: UILabel = {
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
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImageUrls.count
    }
    
    func setupCollectionViewCell(arrayOfImageUrls: [Object.Images]) {
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
        viewPhotos.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! PhotoCollectionViewCell
        cell.backgroundColor = .white
        cell.setupCell(url: arrayOfImageUrls[indexPath.row])
        cell.imageView.image = UIImage(named: "carPlaceholder")
        downloadImage(from: URL(string: arrayOfImageUrls[indexPath.row])!, completion: { (image, url) in
            if url.absoluteString == cell.imageUrl! {
                cell.imageView.image = image
            }
        })
        
        return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage, URL) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                completion(UIImage(data: data)!, url)
            }
        }
    }
    
    func setupCell() {
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.contentView.frame.width, height: self.contentView.frame.height / 2)
        viewPhotos = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        viewPhotos.collectionViewLayout = layout
        viewPhotos.showsHorizontalScrollIndicator = true
        viewPhotos.indicatorStyle = .white
        viewPhotos.isPagingEnabled = true
        viewPhotos.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewID")
        
        viewPhotos.dataSource = self
        viewPhotos.delegate = self
        viewPhotos.backgroundColor = .white
        
        self.contentView.addSubview(viewPhotos)
        
        viewPhotos.translatesAutoresizingMaskIntoConstraints = false
        viewPhotos.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        viewPhotos.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        viewPhotos.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        viewPhotos.bottomAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

            // add labelTwo to the scroll view
            view.addSubview(labelTwo)

        

            // constrain labelTwo at 1000-pts from the top
            labelTwo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 18).isActive = true

            // constrain labelTwo to right & bottom with 16-pts padding
            labelTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18).isActive = true
            //labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
            
            view.addSubview(shareButton)
            
            shareButton.topAnchor.constraint(equalTo: labelTwo.topAnchor).isActive = true
            shareButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18).isActive = true
            
            view.addSubview(labelThree)
            
            // constrain labelTwo at 1000-pts from the top
            labelThree.topAnchor.constraint(equalTo: labelTwo.bottomAnchor, constant: 18).isActive = true

            // constrain labelTwo to right & bottom with 16-pts padding
            labelThree.leftAnchor.constraint(equalTo: labelTwo.leftAnchor).isActive = true
            //labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
            
            view.addSubview(labelYear)
            
            labelYear.topAnchor.constraint(equalTo: labelThree.bottomAnchor, constant: 10).isActive = true

            // constrain labelTwo to right & bottom with 16-pts padding
            labelYear.leftAnchor.constraint(equalTo: labelThree.leftAnchor).isActive = true
            labelYear.widthAnchor.constraint(equalToConstant: 45).isActive = true
            labelYear.heightAnchor.constraint(equalToConstant: 22).isActive = true
            
            view.addSubview(labelMileage)
            
            labelMileage.centerYAnchor.constraint(equalTo: labelYear.centerYAnchor).isActive = true

            // constrain labelTwo to right & bottom with 16-pts padding
            labelMileage.leftAnchor.constraint(equalTo: labelYear.rightAnchor, constant: 10).isActive = true
            
            view.addSubview(labelZipCode)
            
            labelZipCode.centerYAnchor.constraint(equalTo: labelYear.centerYAnchor).isActive = true

            // constrain labelTwo to right & bottom with 16-pts padding
            labelZipCode.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
            
            view.addSubview(labelHistory)
            
            labelHistory.topAnchor.constraint(equalTo: labelYear.bottomAnchor, constant: 10).isActive = true

            // constrain labelTwo to right & bottom with 16-pts padding
            labelHistory.leftAnchor.constraint(equalTo: labelYear.leftAnchor).isActive = true
            labelHistory.heightAnchor.constraint(equalToConstant: 22).isActive = true
            labelHistory.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
