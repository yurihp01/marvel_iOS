//
//  DetailCoordinator.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 11/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    var char: Char
    
    init(navigationController: UINavigationController, char: Char) {
        self.navigationController = navigationController
        self.char = char
    }
    
    func start() {
        let viewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.coordinator = self
        viewController.viewModel = DetailViewModel(char: char)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
}

extension DetailCoordinator: DetailProtocol {
    func showComic(char: Char) {
        let childCoordinator = ComicCoordinator(navigationController, char)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    
}
