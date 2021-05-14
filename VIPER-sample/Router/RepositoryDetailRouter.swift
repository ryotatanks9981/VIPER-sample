//
//  RepositoryDetailRouter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/14.
//

import Foundation
import UIKit

protocol RepositoryDetailWriteframe: AnyObject {
}

class RepositoryDetailRouter {
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule(repository: ArticleEntity) {
        
    }
}
