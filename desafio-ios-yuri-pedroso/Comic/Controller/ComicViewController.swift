//
//  MarvelCharComicViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 30/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

final class ComicViewController: CSViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - PROPERTIES
    var viewModel: ComicViewModel?
    weak var coordinator: ComicCoordinator?
    
    // MARK: - OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        getComicsByCharacterId()
    }
    
    deinit {
        print("deinitialization: ComicViewController")
        coordinator?.childDidFinish(coordinator)
    }
    
    // MARK: - Functions
    
    private func configViews() {
        title = viewModel?.name
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func configViews(comic: Comic, priceFormatted: String) {
        guard let url = URL(string: comic.image) else { return }
        self.comicImage.af.setImage(withURL: url)
        self.comicTitleLabel.text = comic.title
        self.comicDescriptionLabel.text = comic.description
        
        self.valueLabel.text = priceFormatted
        self.valueLabel.isHidden = false
    }
    
    private func getComicsByCharacterId() {
        viewModel?.getComicCharactersById { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {

                self.indicator.stopAnimating()
                
                switch result {
                case .success(let tuppleComicAndPrice):
                    self.configViews(comic: tuppleComicAndPrice.0, priceFormatted: tuppleComicAndPrice.1)
                case .failure(let error):
                    let alert = MarvelAlert.showAlertDialog(title: "Ocorreu um erro", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    self.valueLabel.isHidden = true
                }
            }
        }
    }
}
        

