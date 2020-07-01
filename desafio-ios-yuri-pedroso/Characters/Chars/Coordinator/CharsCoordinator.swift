//
//  CharsCoordinator.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 10/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class CharsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UIStoryboard(name: "Chars", bundle: nil).instantiateViewController(withIdentifier: "CharactersTableViewController") as! CharactersTableViewController
        viewController.viewModel = CharactersViewModel()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}

extension CharsCoordinator: CharactersProtocol {
    func detailChar(char: Char) {
        let childCoordinator = DetailCoordinator(navigationController: navigationController, char: char)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    
}
