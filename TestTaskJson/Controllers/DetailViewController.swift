//
//  DetailViewController.swift
//  TestTaskJson
//
//  Created by Roma on 10/17/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Variables and Constants
    var object: Object? = nil
    let tableView = UITableView(frame: .zero, style: .plain)
    var progress:Float = 0.0

    
    var dataDescription = [[String?]]()
    var dataMenuTitles =
        [[""],["Completion Score"],["Price", "Photos"],
         ["Trim", "Features", "Transmission", "Mileage",
          "Zip Code"],
         ["Email","Phone"]]
    var dataHeaderTitles = ["","","Listing Details", "Vehicle Details", "Contact Info"]
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        return view
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(dissmisVC))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    //MARK: - Init
    init(object: Object) {
        super.init(nibName: nil, bundle: nil)
        self.object = object
        
        progress = Float(object.progress.current) / Float(object.progress.total)
        
        dataDescription =
            [[""],["\(Int(progress*100))%"], ["$\(object.price)","\(object.images.count) Photos"],
             [object.trim, "Add Features", object.transmission, "\(object.mileage) miles",
                object.addresses[0].zipcode],
             [object.owner.email, object.phone]]
    }
    
    //MARK: - Methods (UI Part)
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
    
    //MARK: - Methods (Logic Part)
    @objc func dissmisVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Others
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataMenuTitles[0].count
        case 1:
            return dataMenuTitles[1].count
        case 2:
            return dataMenuTitles[2].count
        case 3:
            return dataMenuTitles[3].count
        default:
            return dataMenuTitles[4].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bigCell", for: indexPath) as! BigCell
            cell.setupCell(object: object!)
            return cell
        } else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! ProgressCell
            cell.setupCell(progress: progress, mainLabelText: dataMenuTitles[indexPath.section][indexPath.row], descriptionLabelText:  dataDescription[indexPath.section][indexPath.row] ?? "No data")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
            cell.setupCell(mainLabelText: dataMenuTitles[indexPath.section][indexPath.row], descriptionLabelText: dataDescription[indexPath.section][indexPath.row] ?? "No data")
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataMenuTitles.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.layer.masksToBounds = false
        headerView.layer.borderWidth = 0.5
        headerView.layer.borderColor = UIColor.lightGray.cgColor
        
        let label = UILabel()
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = dataHeaderTitles[section]
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

