//
//  RootViewController.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    weak var usersListNavigationController: UsersListNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usersListNavigationController = childViewControllers[0] as? UsersListNavigationController
        
        let urlSession = URLSession.shared
        let store = Store()
        
        let userService = UserService(userRepository: CachingUserRepository(
            repository: APIUserRepository(networkSession: urlSession),
            store: store)
        )
        
        let postService = PostService(postRepository: CachingPostRepository(
            repository: APIPostRepository(networkSession: urlSession),
            store: store)
        )
        
        usersListNavigationController?.usersListDataProvider = UsersListDataProvider(userService: userService)
        usersListNavigationController?.postsListDataProvider = { PostsListDataProvider(userId: $0, postService: postService) }
    }

}
