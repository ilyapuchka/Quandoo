//
//  UsersList.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

class UsersList: UIViewController, SeguePerformer {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UsersListCell.nib)
        }
    }
    
    var dataProvider: UsersListDataProvider!
    var model: UsersListViewModel! {
        didSet {
            tableView.reloadData()
        }
    }
    weak var flowController: UsersListNavigationController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataProvider.getUsers { [weak self] (users, error) in
            self?.model = users
        }
    }
    
    lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueManager.prepare(for: segue)
    }

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let flowController = flowController else { return }
        let user = model.user(at: indexPath.row)!
        flowController.showPosts(from: self, userId: user.id, username: user.username)
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

class UsersListDataProvider {
    
    let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func getUsers(completion: @escaping (UsersListViewModel?, Error?) -> Void) {
        userService.getUsers { (users, error) in
            completion(users.map(UsersListViewModel.init(users:)), error)
        }
    }
    
}
