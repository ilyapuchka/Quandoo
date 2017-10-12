//
//  UsersList.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

class UsersList: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UsersListCell.nib)
        }
    }
    
    var model: UsersListViewModel!
}

extension UsersList: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else { return 0 }
        return model.numberOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.reuseIdentifier, for: indexPath)!
        cell.update(withViewModel: model.user(at: indexPath.row)!)
        return cell
    }
    
}

struct UsersListViewModel {
    let users: [UsersListCellViewModel]
    
    init(users: [User]) {
        self.users = users.map(UsersListCellViewModel.init(user:))
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func user(at index: Int) -> UsersListCellViewModel? {
        guard index < users.count else { return nil }
        return users[index]
    }
    
}
