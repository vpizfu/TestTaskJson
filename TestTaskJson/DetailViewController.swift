//
//  DetailViewController.swift
//  TestTaskJson
//
//  Created by Roma on 10/17/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var object: Object? = nil
    let tableView = UITableView(frame: .zero, style: .plain)
    var data = [[String]]()
    var data2 = [[String?]]()
     var progress:Float = 0.0
    
    var data3 = ["","","Listing Details", "Vehicle Details", "Contact Info"]
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ProgressCell.self, forCellReuseIdentifier: "progressCell")
        tableView.register(BigCell.self, forCellReuseIdentifier: "bigCell")
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
    }
    
    init(object: Object) {
        super.init(nibName: nil, bundle: nil)
        self.object = object
         data =
               [[""],["Completion Score"],["Price", "Photos"],
               ["Trim", "Features", "Transmission", "Mileage",
                   "Zip Code"],
               ["Email","Phone"]]
               
               progress = Float(object.progress.current) / Float(object.progress.total)
               
               data2 =
                [[""],["\(Int(progress*100))%"], ["$\(object.price)","\(object.images.count) Photos"],
               [object.trim, "Add Features", object.transmission, "\(object.mileage) miles",
                   object.addresses[0].zipcode],
               [object.owner.email, object.phone]]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(dissmisVC))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func createAttributedTitle(label: UILabel) {
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 19)]
        let lightAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        let firstString = NSMutableAttributedString(string:"\(object?.make ?? "no make") ", attributes:attrs)
        let secondString = NSMutableAttributedString(string:"\(object?.model ?? "no model") ", attributes:attrs)
        let thirdString = NSMutableAttributedString(string:object?.trim ?? "no trim", attributes:lightAttrs)
        firstString.append(secondString)
        firstString.append(thirdString)
        label.attributedText = firstString
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore the navigation bar to default
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.shadowImage = nil
    }
    
    @objc func dissmisVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data[0].count
        case 1:
            return data[1].count
        case 2:
            return data[2].count
        case 3:
            return data[3].count
        default:
            return data[4].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigCell", for: indexPath) as! BigCell
            cell.setupCell()
            cell.setupCollectionViewCell(arrayOfImageUrls: object!.images)
            cell.labelTwo.text = "$\(object?.price ?? 0)"
            createAttributedTitle(label: cell.labelThree)
            cell.labelYear.text = "\(object?.year ?? 0)"
            cell.labelMileage.text = "\(object?.mileage ?? 0) miles"
            cell.labelZipCode.text = "\(object?.addresses[0].zipcode ?? "No Zip Code")"
            return cell
        } else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressCell
            cell.setupCell()
            cell.progressBar.progress = progress
            cell.mainLabel.text = data[indexPath.section][indexPath.row]
            cell.descriptionLabel.text = data2[indexPath.section][indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
            cell.setupCell()
            cell.mainLabel.text = data[indexPath.section][indexPath.row]
            cell.descriptionLabel.text = data2[indexPath.section][indexPath.row]
            switch data[indexPath.section][indexPath.row] {
            case "Mileage":
                cell.deleteArrow()
            case "Features":
                cell.descriptionLabel.textColor = .systemBlue
            default:
                cell.descriptionLabel.textColor = .lightGray
            }

            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.layer.masksToBounds = false
        headerView.layer.borderWidth = 0.5
        headerView.layer.borderColor = UIColor.lightGray.cgColor
        let label = UILabel()
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = data3[section]
        label.font = UIFont.boldSystemFont(ofSize:13) // my custom font
        label.textColor = UIColor.gray.withAlphaComponent(0.8) // my custom colour

        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        } else {
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
             return 350
        } else {
            return 60
        }
    }
}

