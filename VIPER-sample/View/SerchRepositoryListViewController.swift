//
//  ArticleListViewController.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/11.
//

import Foundation
import UIKit
import PKHUD

protocol SearchRepositoryListView: AnyObject {
    func updateArticles(_ articles: [RepositoryEntity])
    func showError(error: Error)
    func showLoadView()
    func dismissLoadView()
}

final class SerchRepositoryListViewController: UIViewController {
    
    var presenter: SearchRepositoryListPresentation!
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.id)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "検索ワード"
        searchBar.delegate = self
        return searchBar
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private var repository: [RepositoryEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pulldown(sender:)), for: .valueChanged)
    }
    
    @objc private func pulldown(sender: UIRefreshControl) {
        guard let text = searchBar.text else { return }
        presenter.pulldown(searchText: text)
        refreshControl.endRefreshing()
    }
}

extension SerchRepositoryListViewController: SearchRepositoryListView {
    func dismissLoadView() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
    
    func showLoadView() {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }
    
    func updateArticles(_ articles: [RepositoryEntity]) {
        self.repository = articles
    }
    func showError(error: Error) {
        let alert = UIAlertController(title: "\(error)", message: "しばらく時間をおいてから再度お試しください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SerchRepositoryListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchButtonDidPush(searchText: text)
        searchBar.resignFirstResponder()
    }
}

extension SerchRepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repository.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.id, for: indexPath) as! RepositoryCell
        cell.setArticle(repository[indexPath.row])
        return cell
    }
    
    
}

extension SerchRepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(repository: repository[indexPath.row])
    }
}
