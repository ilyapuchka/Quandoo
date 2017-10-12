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
        let userRepository = APIUserRepository(networkSession: urlSession)
        let userService = UserService(userRepository: userRepository)
        
        let postRepository = APIPostRepository(networkSession: urlSession)
        let postService = PostService(postRepository: postRepository)
        
        usersListNavigationController?.usersListDataProvider = UsersListDataProvider(userService: userService)
        usersListNavigationController?.postsListDataProvider = { PostsListDataProvider(userId: $0, postService: postService) }
    }

}
