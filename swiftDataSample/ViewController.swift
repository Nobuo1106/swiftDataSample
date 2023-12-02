//
//  ViewController.swift
//  swiftDataSample
//
//  Created by 五十嵐伸雄 on 2023/12/01.
//

import UIKit
import SwiftData

class ViewController: UIViewController {
    var container: ModelContainer?
    var dataSource: UITableViewDiffableDataSource<Section, User>?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container = try? ModelContainer(for: User.self)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "User")
        createTableViewDatasource()
        loadUsers()
    }
    
    func loadUsers() {
        let descriptor = FetchDescriptor<User>()
        let users = (try? container?.mainContext.fetch(descriptor)) ?? []

        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.users])
        snapshot.appendItems(users)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func addSamples(name: String) {
        container?.mainContext.insert(User(name: name))
        loadUsers()
        textField.text = ""
    }
    
    private func createTableViewDatasource() {
        dataSource = UITableViewDiffableDataSource<Section, User>(tableView: tableView) { tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = "\(user.name)"
            cell.contentConfiguration = content
            return cell
        }
    }
    
    @IBAction func addButtonDidTap(_ sender: UIButton) {
        if let name = textField.text {
            addSamples(name: name)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}
