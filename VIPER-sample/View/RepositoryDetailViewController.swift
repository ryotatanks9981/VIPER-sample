//
//  RepositoryDetailViewController.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/14.
//

import Foundation
import UIKit
import WebKit

protocol RepositoryDetailView: AnyObject {
    func load(request urlRequest: URLRequest)
}

final class RepositoryDetailViewController: UIViewController {
    
    var presenter: RepositoryDetailPresentation!
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        presenter.viewDidLoad()
        
        webView.frame = view.frame
        view.addSubview(webView)
    }
}

extension RepositoryDetailViewController: RepositoryDetailView {
    func load(request urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}
