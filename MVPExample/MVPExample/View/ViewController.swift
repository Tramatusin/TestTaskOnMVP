//  ViewController.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 06.08.2021.


import UIKit

class ViewController: UIViewController, PresenterInput{
    
    func setDataInView(items: (elements: [AnotherItemBase]?,queue: [String])) {
        guard let itemsForView = items.elements else {return}
        mainView.labelData = itemsForView[0] as? Label
        mainView.imageData = itemsForView[1] as? Image
        mainView.selectorData = itemsForView[2] as? Selector
        DispatchQueue.main.async {
            self.viewQueue = items.queue
            self.tableForItems.reloadData()
            self.mainView.setupData()
        }
    }
    
    var viewQueue: [String] = []
    var presenter: PresenterDelegate!
    let mainView = ViewForItems()
    let viewControllerForItems = ItemsViewController()
    
    lazy var tableForItems: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(TableViewCellForItem.self, forCellReuseIdentifier: TableViewCellForItem.tableViewCellId)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerForItems.view = mainView
        setupConstraint()
        presenter?.setCarthage()
    }
    
    func setupConstraint(){
        view.addSubview(tableForItems)
        
        NSLayoutConstraint.activate([
            tableForItems.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableForItems.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableForItems.topAnchor.constraint(equalTo: view.topAnchor),
            tableForItems.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewQueue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellForItem.tableViewCellId, for: indexPath) as! TableViewCellForItem
        cell.configureCell(text: viewQueue[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainView.viewData = viewQueue[indexPath.row]
        navigationController?.pushViewController(viewControllerForItems, animated: true)
        print("Активирован раздел с \(viewQueue[indexPath.row])")
    }
}

