//
//  NewsFeedViewController.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import UIKit
import Foundation
import SystemConfiguration

class NewsFeedViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    var activityIndicator = UIActivityIndicatorView()
    let viewModel = NewsFeedViewModel()
    var filterVc = FilterViewController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().userInterfaceIdiom == .pad {
            newsFeedTableView.isHidden = true
            setupCollectionViewForiPad()
        } else {
            feedCollectionView.isHidden = true
            setUpTableView()
        }
        
        showNetworkOfflineAlert()
        configureTitle()
        configureActivityIndicator()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let filteredFeed = filterVc.filteredFeed
        if !filteredFeed.isEmpty {
            viewModel.displayFilteredFeed(filteredFeed: filterVc.filteredFeed)
        } else {
            viewModel.fetchFeedFromCache()
        }
    }
    
    func initViewModel() {
        viewModel.updatingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2) {
                        if UIDevice().userInterfaceIdiom == .pad {
                            self?.feedCollectionView.alpha = 0
                        } else {
                            self?.newsFeedTableView.alpha = 0
                        }
                    }
                } else {
                    self!.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2) {
                        if UIDevice().userInterfaceIdiom == .pad {
                            self?.feedCollectionView.alpha = 1.0
                        } else {
                            self?.newsFeedTableView.alpha = 1.0
                        }
                    }
                }
            }
        }
        reloadFeedView()
        viewModel.fetchNewsFeed()
    }
    
    func setUpTableView() {
        newsFeedTableView?.register(
            UINib(nibName: Constants.ViewCells.NewsFeedCell,
                  bundle: nil),
            forCellReuseIdentifier: Constants.ViewCells.NewsFeedCell)
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        view.backgroundColor = .white
        activityIndicator.color = .red
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func configureTitle() {
        self.navigationItem.title = "NewsPlus"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func reloadFeedView() {
        viewModel.reloadView = { [weak self] () in
            DispatchQueue.main.async {
                if UIDevice().userInterfaceIdiom == .pad {
                    self?.feedCollectionView.reloadData()
                } else {
                    self?.newsFeedTableView.reloadData()
                }
            }
        }
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func showNetworkOfflineAlert() {
        if !isInternetAvailable() {
            viewModel.fetchFeedFromCache()
            let alertVC = CustomAlertViewController(alertTitle: "No internet connection", message: "Offline mode is enabled", buttonTitle: "Dismiss")
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    // MARK: - Selectors
    
    @objc func filterTapped() {
        filterVc = FilterViewController(nibName: "FilterViewController", bundle: nil)
        self.navigationController?.pushViewController(filterVc, animated: true)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension NewsFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCellModels
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.ViewCells.NewsFeedCell, for: indexPath)
                as? NewsFeedCell else {
            fatalError("NewsFeedCell typecast ")
        }
        let cellModel = viewModel.getCellAtRow(indexPath: indexPath)
        cell.configure(feed: cellModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}
