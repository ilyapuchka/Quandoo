//
//  UsersList.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

class UsersList: UIViewController, SeguePerformer {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerReusableViews()
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    var dataProvider: UsersListDataProvider!
    var model: UsersListViewModel = UsersListViewModel() {
        didSet {
            if model.isLoading {
                loadingView?.startAnimating()
                tableView?.isHidden = true
            } else {
                loadingView?.stopAnimating()
                tableView?.isHidden = false
                tableView?.reloadData()
            }
        }
    }
    weak var flowController: UsersListNavigationController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        model.isLoading = true
        dataProvider.getUsers { [weak self] (users, error) in
            self?.model = users ?? UsersListViewModel()
        }
    }
    
    lazy var segueManager: SegueManager = { return SegueManager(viewController: self) }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueManager.prepare(for: segue)
    }

}

extension UsersList: ListView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let flowController = flowController else { return }
        guard let user = model.item(at: indexPath.row) else { return }
        flowController.showPosts(from: self, userId: user.id, username: user.username)
    }
    
}

struct UsersListViewModel: ListViewModel {
    typealias Item = UsersListCellViewModel
    typealias Cell = UsersListCell

    let users: [UsersListCellViewModel]
    var isLoading: Bool = false
    
    init(users: [User] = []) {
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
