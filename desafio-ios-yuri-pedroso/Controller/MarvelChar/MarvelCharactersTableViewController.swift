//
//  MarvelCharactersTableViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 29/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class MarvelCharactersTableViewController: CSViewController {

    var chars: [Char] = []
    var offset: Int = 0
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        getMarvelCharacters()
    }
    
    private func configViews() {
        view.addSubview(indicator)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Functions
    private func getMarvelCharacters() {
        indicator.startAnimating()
        tableView.setContentOffset(CGPoint(x: 0, y: -self.tableView.contentInset.top - 80), animated: false)
        
        MarvelAPI.getChars(offset: self.offset) { [weak self] (result, totalCharacters) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                
                switch result {
                case .success(let characters):
                    guard let total = totalCharacters else { return }
                    self.setButtonsEnabledAndAlpha(total: total)
                    self.chars = characters
                    self.tableView.reloadData()
                case .failure(let error):
                    let alert = MarvelAlert.showAlertDialog(title: "Ocorreu um erro!", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func setButtonsEnabledAndAlpha(total: Int) {
        buttonView.isHidden = false
        switch offset {
        case 0:
            backButton.isEnabled = false
            backButton.alpha = 0.5
        case  1..<total:
            backButton.isEnabled = true
            backButton.alpha = 1
            nextButton.isEnabled = true
            nextButton.alpha = 1
        default:
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        }
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController, let row = tableView.indexPathForSelectedRow?.row else { return }
        vc.char = chars[row]
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        offset -= 20
        getMarvelCharacters()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        offset += 20
        getMarvelCharacters()
    }
}

extension MarvelCharactersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chars.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MarvelCharTableViewCell else { return UITableViewCell()
        }
        cell.prepareCell(with: chars[indexPath.row])
        return cell
    }
}
