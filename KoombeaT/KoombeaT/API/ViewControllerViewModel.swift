//
//  ViewControllerViewModel.swift
//  KoombeaT
//
//  Created by Lazaro Neto on 13/10/23.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    
    func didFetchUsers()
}

class ViewModel {
    
    private let requester: UserRequest
    private(set) var users = [User]()
    
    private weak var delegate: ViewModelDelegate?
    
    init(requester: UserRequest = UserRequester(),
         viewModelDelegate: ViewModelDelegate) {
        self.requester = requester
        self.delegate = viewModelDelegate
    }
    
    func fetchUsers() {
        
        self.requester.fetchUsers { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(users):
                self.users = users ?? []
            case let .failure(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.delegate?.didFetchUsers()
            }
        }
        
    }
}
