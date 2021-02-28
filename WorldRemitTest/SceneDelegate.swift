//
//  SceneDelegate.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let viewController = UsersViewController.instantiate(from: .main)
        let navigationController = UINavigationController(rootViewController: viewController)

//        if ProcessInfo.processInfo.arguments.contains("UI-TESTING") {
//            let mockURL = URL(string: "https://test.com/2.2/users?pagesize=20&order=desc&sort=reputation&site=stackoverflow")!
//            let jsonData = try! Data.fromJSON(fileName: "GET_Users_ValidResponse")
//            let urlResponse = HTTPURLResponse(url: mockURL,
//                                              statusCode: 200,
//                                              httpVersion: nil,
//                                              headerFields: nil)
//            let mockURLSession = MockURLSession(data: jsonData,
//                                                urlResponse: urlResponse,
//                                                error: nil)
//            let sut = NetworkingService(session: mockURLSession)
//            viewController.viewModel = UsersViewModel(networkService: sut)
//        } else {
        let services = Services()
        viewController.viewModel = UsersViewModel(usersService: services.usersService,
                                                  decimalFormatter: services.decimalFormatter,
                                                  imageDownloader: services.imageDownloader)
//        }

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

