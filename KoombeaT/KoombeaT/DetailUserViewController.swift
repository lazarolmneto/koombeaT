//
//  DetailUserViewController.swift
//  KoombeaT
//
//  Created by Lazaro Neto on 13/10/23.
//

import UIKit

class DetailUserViewController: UIViewController {

    // Components
    let mainStackView = UIStackView()
    let userImageParent = UIView()
    let userImage = UIImageView()
    let usernameLabel = UILabel()
    let emailLabel = UILabel()
    let firstNameLabel = UILabel()
    
    let user: User
    
    init(user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLayout()
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.addSubviews()
        self.setupMainStack()
        self.setupImageView()
        self.fillInfo()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.mainStackView)
        
        self.mainStackView.addArrangedSubview(self.userImageParent)
        self.mainStackView.addArrangedSubview(self.usernameLabel)
        self.mainStackView.addArrangedSubview(self.emailLabel)
        self.mainStackView.addArrangedSubview(self.firstNameLabel)
        
        self.userImageParent.addSubview(self.userImage)
    }

    private func setupMainStack() {
        self.mainStackView.axis = .vertical
        self.mainStackView.spacing = 10
        self.mainStackView.distribution = .fillProportionally
        self.mainStackView.alignment = .center
        
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.mainStackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func setupImageView() {
        
        self.userImageParent.translatesAutoresizingMaskIntoConstraints = false
        self.userImageParent.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.userImage.translatesAutoresizingMaskIntoConstraints = false
        self.userImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.userImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.userImage.centerXAnchor.constraint(equalTo: self.userImageParent.centerXAnchor).isActive = true
        self.userImage.centerYAnchor.constraint(equalTo: self.userImageParent.centerYAnchor).isActive = true
    }
    
    private func fillInfo() {
        
        self.usernameLabel.text = self.user.username
        self.emailLabel.text = self.user.email
        self.firstNameLabel.text = self.user.firstName
        
        guard let url = URL(string: self.user.pictureURL) else { return }
        self.downloadImage(from: url)
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.userImage.image = UIImage(data: data)
            }
        }
    }
}
