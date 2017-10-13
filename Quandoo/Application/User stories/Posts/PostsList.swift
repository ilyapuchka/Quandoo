//
//  PostsList.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit
import Rswift

class PostsList: UIViewController {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            registerReusableViews()
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    var dataProvider: PostsListDataProvider!
    var model: PostsListViewModel = PostsListViewModel() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        model.isLoading = true
        if let userId = model.userId {
            dataProvider.getUserPosts(userId: userId) { [weak self] (posts, error) in
                self?.model = posts ?? PostsListViewModel()
            }
        }
    }

}

extension PostsList: ListView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
}

struct PostsListViewModel: ListViewModel {
    typealias Item = PostsListCellViewModel
    typealias Cell = PostsListCell
    
    let userId: Int!
    let posts: [PostsListCellViewModel]
    var isLoading: Bool = false
    
    init(userId: Int! = nil, posts: [Post] = []) {
        self.userId = userId
        self.posts = posts.map(PostsListCellViewModel.init(post:))
    }
    
    func numberOfRows() -> Int {
        return posts.count
    }
    
    func item(at index: Int) -> Item? {
        guard index < posts.count else { return nil }
        return posts[index]
    }

}

class PostsListDataProvider {
    
    let postService: PostService
    
    init(postService: PostService) {
        self.postService = postService
    }
    
    func getUserPosts(userId: Int, completion: @escaping (PostsListViewModel?, Error?) -> Void) {
        postService.getPosts(withUserId: userId) { (posts, error) in
            completion(posts.map({ PostsListViewModel(userId: userId, posts: $0) }), error)
        }
    }
    
}

