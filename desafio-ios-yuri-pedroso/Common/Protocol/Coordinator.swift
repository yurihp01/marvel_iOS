//
//  Coordinator.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 10/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func add(childCoordinator coordinator: Coordinator)
    func remove(childCoordinator coordinator: Coordinator)
    func back()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func add(childCoordinator coordinator: Coordinator) -> Void {
        childCoordinators.append(coordinator)
    }
    
    func remove(childCoordinator coordinator: Coordinator) {
        childCoordinators.removeAll { coordinator === $0 }
    }
    
    func back() {}
    
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        remove(childCoordinator: child)
    }
}
