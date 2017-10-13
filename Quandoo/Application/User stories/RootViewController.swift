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
        
        // This is the entry point of the app. Dependency injection is performed here in a simple way.
        // This container is used to separate main storyboard and users list storyboard.
        // In real life scenario this controller will be probably a subclass of UITabBarController
        // or some other kind of container
        
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
        usersListNavigationController?.postsListDataProvider = PostsListDataProvider(postService: postService)
    }

}
