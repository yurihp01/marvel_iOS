//
//  CSViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 31/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class CSViewController: UIViewController {

    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.center = view.center
        indicator.color = .black
        indicator.style = .whiteLarge
        indicator.hidesWhenStopped = true
        return indicator
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
