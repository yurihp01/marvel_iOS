//
//  CharTableViewCell.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 29/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit
import AlamofireImage

class CharTableViewCell: UITableViewCell {

    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charLabel: UILabel!
    
    func prepareCell(with char: Char) {
        guard let url = URL(string: char.image) else { return }
        charImage.af.setImage(withURL: url)
        charLabel.text = char.name
    }
    
}
