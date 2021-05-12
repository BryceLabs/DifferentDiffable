//
//  ViewController.swift
//  DifferentDiffable
//
//  Created by Bryan Bryce on 5/12/21.
//

import UIKit
import Combine

enum Item: Hashable {
    case number(UUID, Int)
    case date(UUID, Date)
    case 🌮(UUID)
}

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var dataSource: UITableViewDiffableDataSource<Int, Item>!
    
    var items = CurrentValueSubject<[Item], Never>([.number(UUID(), 0), .🌮(UUID()), .number(UUID(), 5), .date(UUID(), Date()),])
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(letsDoThis))
       
        self.dataSource = UITableViewDiffableDataSource<Int, Item>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            switch item {
            case .number(_, let num):
                let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell", for: indexPath) as! NumberCell
                cell.configure(num)
                return cell
            case .date(_ , let date):
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateCell
                cell.configure(date)
                return cell
            case .🌮(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: "🌮Cell", for: indexPath) as! 🌮Cell
                return cell
            }
        }
        
        items
            .receive(on: DispatchQueue.main)
            .sink { items in
                var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
                
                snapshot.appendSections([0])
                snapshot.appendItems(items, toSection: 0)
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &cancellables)
        
    }
    
    @objc func letsDoThis(sender: Any) {
                
        var newItems: [Item] = items.value.map {
            switch $0 {
            
            case .number(let id, let num):
                return Item.number(id, num + 1)
            case .date(let id, _):
                return Item.date(id, Date())
            case .🌮(let id):
                return Item.🌮(id)
            }
        }
        newItems.insert(Item.🌮(UUID()), at: 0)
        newItems.append(Item.🌮(UUID()))

        items.value = newItems
    }
    
    
    
}
