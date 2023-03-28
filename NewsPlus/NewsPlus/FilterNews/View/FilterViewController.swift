//
//  FilterViewController.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-23.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var filterTableView: UITableView!
    
    var filterViewModel = FilterViewModel()
    var filteredFeed: [NewsFeed] = []
    let filterType = ["Story", "Content package"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Filters"
        setUpTableView()
    }
    
    func setUpTableView() {
        filterTableView?.register(
            UINib(nibName: Constants.ViewCells.FilterCell,
                  bundle: nil),
            forCellReuseIdentifier: Constants.ViewCells.FilterCell)
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.ViewCells.FilterCell, for: indexPath)
                as? FilterCell else {
            fatalError("FilterCell typecast ")
        }
        cell.tintColor = .red
        cell.typeName.text = filterType[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        let selectedType = filterType[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "")
        filterViewModel.filterNewsFeed(selectedType: selectedType) { result in
            switch result {
            case .success(let newsFeed):
                self.filteredFeed = newsFeed
            case .failure:
                print("Filtering failed")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
