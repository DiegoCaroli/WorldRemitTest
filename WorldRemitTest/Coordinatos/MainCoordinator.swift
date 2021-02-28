//
//  MainCoordinator.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 28/02/2021.
//  Copyright © 2021 Diego Caroli. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    internal var navigationController: UINavigationController
    internal var childCoordinators: [Coordinator]

    private let window: UIWindow
    private let services: Services

    init(window: UIWindow,
         services: Services) {
        self.navigationController = UINavigationController()
        self.childCoordinators = []
        self.window = window
        self.services = services
        self.window.rootViewController = self.navigationController
    }

    func start() {
        let viewController = UsersViewController.instantiate(from: .main)
        let viewModel = UsersViewModel(usersService: services.usersService,
                                       decimalFormatter: services.decimalFormatter,
                                       imageDownloader: services.imageCache)

        viewController.viewModel = viewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func addErrorLoading() {
        let vc = ErrorLoadingViewController.instantiate(from: .main)
        navigationController.viewControllers.last?.add(vc)
    }

    func removeErrorLoading() {
        guard let vc = navigationController
                .viewControllers
                .last?
                .children
                .first as? ErrorLoadingViewController else { return }
        vc.remove()
    }

    func showError(_ error: Error) {
        guard let vc = navigationController
                .viewControllers
                .last?
                .children
                .first as? ErrorLoadingViewController else { return }
        vc.setupError(error)
    }

}
