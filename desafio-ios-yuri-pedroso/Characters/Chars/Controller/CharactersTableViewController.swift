//
//  MarvelCharactersTableViewController.swift
//  desafio-ios-yuri-pedroso
//
//  Created by Yuri on 29/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

protocol CharactersProtocol: class {
    func detailChar(char: Char)
}

final class CharactersTableViewController: CSViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    var offset: Int = 0
    lazy var viewModel = CharactersViewModel()
    weak var coordinator: CharactersProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        getMarvelCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        viewModel.getMarvelCharacters(offset: offset, onComplete: { [weak self] (result, total) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.indicator.stopAnimating()
                    self.setButtonsEnabledAndAlpha(total: total ?? 0)
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.indicator.stopAnimating()
                    let alert = MarvelAlert.showAlertDialog(title: "Ocorreu um erro!", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
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
    
    @IBAction func backButton(_ sender: UIButton) {
        offset -= 20
        getMarvelCharacters()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        offset += 20
        getMarvelCharacters()
    }
}

extension CharactersTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chars.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CharTableViewCell else { return UITableViewCell()
        }
        
        cell.prepareCell(with: viewModel.chars[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.detailChar(char: viewModel.chars[indexPath.row])
    }
}
