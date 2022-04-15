//
//  ViewController.swift
//  RickMorty
//
//  Created by Nodirbek on 14.04.2022.
//

import UIKit

final class FirstViewController: UIViewController {
    
    var viewModel: ViewModeling!
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        setupBindings()
        viewModel.getData(with: 4)
    }

    private func setupBindings() {
        viewModel.didChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func presentSecondViewController(for index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let item = viewModel.item(for: index)
        let viewModel = SecondViewModel(model: item)
        vc.viewModel = viewModel
        navigationController?.present(vc, animated: true)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let item = viewModel.item(for: indexPath.row)
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentSecondViewController(for: indexPath.row)
    }
    
    
    
}


