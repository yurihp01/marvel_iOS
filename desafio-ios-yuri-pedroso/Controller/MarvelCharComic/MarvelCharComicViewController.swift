//
//  MarvelCharComicViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 30/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class MarvelCharComicViewController: CSViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - PROPERTIES
    var char: Char?
    
    // MARK: - OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        getComicsByCharacterId()
    }
    
    // MARK: - Functions
    
    private func configViews() {
        guard let char = char else { return }
        title = char.name
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func getComicsByCharacterId() {
        guard let id = char?.id else {
            return
        }

        MarvelAPI.getComic(charId: id) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.indicator.stopAnimating()

                switch result {
                case .success(let comics):
                    var highestPrice = -1.0
                    var priceFormatted = ""
                    var marvelComic: Comic?
                
                    comics.forEach { (comic) in
                        guard let price = comic.prices.max(by: { (priceOne, priceTwo) -> Bool in
                            return priceOne.price > priceTwo.price
                        }) else { return }

                        if highestPrice < price.price && (comic.description != nil || price.price >= 0.0) {
                            marvelComic = comic
                            highestPrice = price.price
                            priceFormatted = price.priceValue
                        }
                    }

                    self.configViews(comic: marvelComic, priceFormatted: priceFormatted)
                case .failure(let error):
                    let alert = MarvelAlert.showAlertDialog(title: "Ocorreu um erro", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    self.configErrorBehaviorComponents()
                }
            }
        }
    }
    
    private func configViews(comic: Comic?, priceFormatted: String) {
        guard let comic = comic, let url = URL(string: comic.image) else { return }
        self.comicImage.af.setImage(withURL: url)
        self.comicTitleLabel.text = comic.title
        self.comicDescriptionLabel.text = comic.description
        
        self.valueLabel.text = priceFormatted
        self.valueLabel.isHidden = false
    }
    
    private func configErrorBehaviorComponents() {
        self.valueLabel.isHidden = true
    }
}
        
        
