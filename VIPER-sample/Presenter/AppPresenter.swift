//
//  AppPresenter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/11.
//

import Foundation

protocol AppPresentation {
    func didFinishLaunch()
}

final class AppPresenter {
    private let router: AppWriteframe
    
    init(router: AppWriteframe) {
        self.router = router
    }
}

extension AppPresenter: AppPresentation {
    func didFinishLaunch() {
        router.showArticleListView()
    }
}
