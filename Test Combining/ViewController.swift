//
//  ViewController.swift
//  Test Combining
//
//  Created by Salah  on 03/01/2021.
//

import UIKit
import Combine

class ViewController: UIViewController{
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var userSubscriber:AnyCancellable?
    
    private var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = 80
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        fetchUsersData()
    }

    
    func fetchUsersData(){
        userSubscriber = DataManager().publisher.sink(receiveCompletion: {_ in}, receiveValue: { (users) in
            self.users = users
            self.tableView.reloadData()
        })
    }

}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        cell.userName.text = users[indexPath.row].username
        cell.fullName.text = users[indexPath.row].name
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
