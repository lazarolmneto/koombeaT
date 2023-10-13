//
//  ViewController.swift
//  KoombeaT
//
//  Created by Lazaro Neto on 13/10/23.
//

import UIKit

class ViewController: UIViewController {

    enum Constants: String {
        case cellIdentifier = "cellIdentifier"
    }
    
    //Components
    let tableView = UITableView()
    
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewModel(viewModelDelegate: self)
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel?.fetchUsers()
    }

    private func setupLayout() {
        self.addSubviews()
        self.setupTableView()
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupTableView() {
     
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier.rawValue)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func didSelectUser(at index: Int) {
     
        guard let user = self.viewModel?.users[index] else { return }
        present(DetailUserViewController(user: user), animated: true)
    }
}

// MARK: - ViewModelDelegate
extension ViewController: ViewModelDelegate {
    
    func didFetchUsers() {
        print(viewModel?.users.count)
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate: UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier.rawValue, for: indexPath)
        
        cell.textLabel?.text = self.viewModel?.users[indexPath.row].firstName ?? "NO TEXT FOUND"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didSelectUser(at: indexPath.row)
    }
}
