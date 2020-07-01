//
//  ComicCoordinator.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 11/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class ComicCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    var char: Char
    
    init(_ navigationController: UINavigationController, _ char: Char) {
        self.navigationController = navigationController
        self.char = char
    }
    
    func start() {
        let viewController = UIStoryboard(name: "Comic", bundle: nil).instantiateViewController(withIdentifier: "ComicViewController") as! ComicViewController
        viewController.viewModel = ComicViewModel(char: char)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
