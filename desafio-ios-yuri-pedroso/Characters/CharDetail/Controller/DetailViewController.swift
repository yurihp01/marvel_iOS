//
//  DetailViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 29/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit
import AlamofireImage

protocol DetailProtocol {
    func showComic(char: Char)
}
    
final class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Variables
    var viewModel: DetailViewModel?
    weak var coordinator: DetailCoordinator?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    deinit {
        print("Deinitialization: DetailViewController")
        coordinator?.childDidFinish(coordinator)
    }
    
    // MARK: - Functions
    private func configViews() {
        guard let viewModel = viewModel else { return }
        title = viewModel.title
        nameLabel.text = viewModel.name
        detailLabel.text = viewModel.description
        characterImage.af.setImage(withURL: viewModel.url)
    }
    
    @IBAction func hqButton(_ sender: UIButton) {
        guard let char = viewModel?.char, let coordinator = coordinator else { return }
        coordinator.showComic(char: char)
    }
}
