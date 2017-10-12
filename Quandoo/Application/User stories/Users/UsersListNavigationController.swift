//
//  UsersListNavigationController.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

class UsersListNavigationController: UINavigationController {

    weak var usersList: UsersList?
    
    var usersListDataProvider: UsersListDataProvider!
    var postsListDataProvider: ((Int) -> PostsListDataProvider)!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if usersList == nil {
            usersList = viewControllers[0] as? UsersList
            usersList?.flowController = self
            usersList?.dataProvider = usersListDataProvider
        }
    }
    
    func showPosts(from: UsersList, userId: Int, username: String) {
        from.performSegue(R.segue.usersList.showPost) { segue in
            segue.destination.dataProvider = self.postsListDataProvider(userId)
            segue.destination.userId = userId
            segue.destination.navigationItem.title = username
        }
    }

}
