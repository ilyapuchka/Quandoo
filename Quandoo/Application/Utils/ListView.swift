//
//  ListView.swift
//  Quandoo
//
//  Created by Ilya Puchka on 13/10/2017.
//  Copyright © 2017 Ilya Puchka. All rights reserved.
//

import UIKit
import Rswift

protocol UpdatableListCell {
    associatedtype ViewModel
    func update(withViewModel: ViewModel) -> Void
}

protocol ListCell {
    associatedtype ReuseableType: UpdatableListCell
    static var reuseIdentifier: ReuseIdentifier<ReuseableType> { get }

    associatedtype NibType: NibResourceType
    static var nib: NibType { get }
}

protocol ListViewModel {
    associatedtype Item
    associatedtype Cell: ListCell
    
    func numberOfRows() -> Int
    func item(at index: Int) -> Item?
}

protocol ListView: UITableViewDataSource, UITableViewDelegate {
    associatedtype ViewModel: ListViewModel
    var model: ViewModel! { get set }
    var tableView: UITableView! { get }
}

extension ListView where
    ViewModel.Cell.ReuseableType.ViewModel == ViewModel.Item,
    ViewModel.Cell.ReuseableType: UITableViewCell,
    ViewModel.Cell.NibType: ReuseIdentifierType,
    ViewModel.Cell.NibType.ReusableType == ViewModel.Cell.ReuseableType
{
    
    func registerReusableViews(in tableView: UITableView) {
        tableView.register(ViewModel.Cell.nib)
    }
    
    func numberOfRows(in tableView: UITableView) -> Int {
        guard let model = model else { return 0 }
        return model.numberOfRows()
    }
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> ViewModel.Cell.ReuseableType {
        let reuseId = ViewModel.Cell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)!
        cell.update(withViewModel: model.item(at: indexPath.row)!)
        return cell
    }
    
}
