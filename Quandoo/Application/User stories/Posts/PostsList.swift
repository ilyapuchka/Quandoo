//
//  PostsList.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

class PostsList: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(PostsListCell.nib)
        }
    }
    
    var model: PostsListViewModel!

}

extension PostsList: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = model else { return 0 }
        return model.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsListCell.reuseIdentifier, for: indexPath)!
        cell.update(withViewModel: model.post(at: indexPath.row)!)
        return cell
    }
    
}

struct PostsListViewModel {
    let posts: [PostsListCellViewModel]
    
    init(users: [Post]) {
        self.posts = users.map(PostsListCellViewModel.init(post:))
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func post(at index: Int) -> PostsListCellViewModel? {
        guard index < posts.count else { return nil }
        return posts[index]
    }
    
}
