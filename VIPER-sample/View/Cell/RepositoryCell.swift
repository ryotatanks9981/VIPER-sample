//
//  ArticleCell.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/13.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    static let id = "ArticleCell"
    
    private let titleNameLabel = UILabel()
    private let starLabel = UILabel()
    private let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.axis = .vertical
        stackView.frame = bounds
        stackView.addArrangedSubview(titleNameLabel)
        stackView.addArrangedSubview(starLabel)
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setArticle(_ article: RepositoryEntity) {
        titleNameLabel.text = article.fullName
        starLabel.text = "Star: \(article.starCount)"
    }
}
