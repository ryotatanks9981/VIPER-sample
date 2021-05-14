//
//  ArticleListViewController.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/11.
//

import Foundation
import UIKit

protocol ArticleListView: AnyObject {
    func updateArticles(_ articles: [ArticleEntity])
    func showError(error: Error)
}

final class ArticleListViewController: UIViewController {
    
    var presenter:ArticleListPresentation!
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.id)
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
    
    private var articles: [ArticleEntity] = [] {
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

extension ArticleListViewController: ArticleListView {
    func updateArticles(_ articles: [ArticleEntity]) {
        self.articles = articles
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

extension ArticleListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchButtonDidPush(searchText: text)
        searchBar.resignFirstResponder()
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.id, for: indexPath) as! ArticleCell
        cell.setArticle(articles[indexPath.row])
        return cell
    }
    
    
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(article: articles[indexPath.row])
    }
}
