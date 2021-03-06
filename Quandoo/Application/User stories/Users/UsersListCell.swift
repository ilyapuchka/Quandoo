//
//  UsersListCell.swift
//  Quandoo
//
//  Created by Ilya Puchka on 12/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit
import Rswift

final class UsersListCell: UITableViewCell, ListCell, UpdatableListCell {

    static let reuseIdentifier = R.reuseIdentifier.usersListCell
    static let nib = R.nib.usersListCell
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.fontStyle = UIFont.title1
        }
    }
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.fontStyle = UIFont.subheadline
        }
    }
    @IBOutlet weak var emailLabel: UILabel! {
        didSet {
            emailLabel.fontStyle = UIFont.subheadline
        }
    }
    @IBOutlet weak var addressLabel: UILabel! {
        didSet {
            addressLabel.fontStyle = UIFont.title3
        }
    }
    
    func update(withViewModel model: UsersListCellViewModel) {
        self.nameLabel?.text = model.name
        self.usernameLabel?.text = model.username
        self.emailLabel?.text = model.email
        self.addressLabel?.text = model.address
    }
    
}

struct UsersListCellViewModel {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: String
    
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.address = [
            user.address.street,
            user.address.suite,
            user.address.city,
            user.address.zipcode
        ].joined(separator: " ")
    }
    
}
