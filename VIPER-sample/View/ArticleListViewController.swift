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
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "検索ワード"
        searchBar.delegate = self
        return searchBar
    }()
    
    private var articles: [ArticleEntity] = [] {
        didSet {
            DispatchQueue.main.async {
//                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        navigationItem.titleView = searchBar
        
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
        print(text)
        searchBar.resignFirstResponder()
    }
}
