//
//  UserListViewController.swift
//  GoraTest
//
//  Created by Dmitry on 10.09.2021.
//

import UIKit

class UserListViewController: UITableViewController {

    private var users = [User]()
    private let cell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUsersData()
    }
    
    private func fetchUsersData() {
        NetworkService.shared.fetchUsersData { result in
            
            switch result {
            
            case .success(let users):
                self.users = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                print("")
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath)
        
        cell.textLabel?.text = users[indexPath.row].name

        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        
        guard let usersPhotoVC = segue.destination as? UserPhotosViewController else {
            return
        }
        
        usersPhotoVC.title = users[indexPath.row].name
        usersPhotoVC.userId = users[indexPath.row].id
        
    }
    

}
