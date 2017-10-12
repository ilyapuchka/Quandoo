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
            registerReusableViews(in: tableView)
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
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

extension UsersList: ListView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let flowController = flowController else { return }
        let user = model.item(at: indexPath.row)!
        flowController.showPosts(from: self, userId: user.id, username: user.username)
    }
    
}

struct UsersListViewModel: ListViewModel {
    typealias Item = UsersListCellViewModel
    typealias Cell = UsersListCell

    let users: [UsersListCellViewModel]
    
    init(users: [User]) {
        self.users = users.map(UsersListCellViewModel.init(user:))
    }
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func item(at index: Int) -> Item? {
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
