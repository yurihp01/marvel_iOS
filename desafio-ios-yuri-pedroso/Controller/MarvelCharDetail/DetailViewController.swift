//
//  DetailViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 29/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit
    
final class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Variables
    var char: Char?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    // MARK: - Functions
    private func configViews() {
        guard let char = char, let url = char.url, let description = char.description else { return }
        title = "Personagem"
        nameLabel.text = char.name
        detailLabel.text = description.isEmpty ? "Este personagem não possui descrição!" : description
        characterImage.af.setImage(withURL: url)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MarvelCharComicViewController else { return }
        vc.char = char
    }
    
    
    @IBAction func hqButton(_ sender: UIButton) {
    }
}
