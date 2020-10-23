//
//  ViewController.swift
//  TestTaskJson
//
//  Created by Roma on 10/16/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Variables and Constants
    var objectArray: [Object]? = nil
    let tableView = UITableView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fillTableWithObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "Choose car"
    }
    
    //MARK: - Methods (UI Part)
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    //MARK: - Methods (Logic Part)
    func fillTableWithObjects() {
        JsonParser().parseJson(url: "https://www.dl.dropboxusercontent.com/s/zjjioeld6zbqu35/listings-temp.json") { (objects) in
            self.objectArray = objects
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = objectArray?[indexPath.row].title
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(object: (objectArray?[indexPath.row])!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

