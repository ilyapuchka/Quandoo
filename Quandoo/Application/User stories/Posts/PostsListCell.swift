//
//  PostsListCell.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit

final class PostsListCell: UITableViewCell {
    static let reuseIdentifier = R.reuseIdentifier.postsListCell
    static let nib = R.nib.postsListCell
    
    func update(withViewModel model: PostsListCellViewModel) {
        self.textLabel?.text = model.title
        self.detailTextLabel?.text = model.body
    }
    
}

struct PostsListCellViewModel {
    let title: String
    let body: String
    
    init(post: Post) {
        self.title = post.title
        self.body = post.body
    }
    
}
