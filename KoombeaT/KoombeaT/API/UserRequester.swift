//
//  UserRequest.swift
//  KoombeaT
//
//  Created by Lazaro Neto on 13/10/23.
//

import Foundation

protocol UserRequest {
    
    func fetchUsers(completion: ((Result<[User]?, Error>) -> Void)?)
}

class UserRequester: UserRequest {
    
    enum Constants: String {
        case userUrl = "https://jserver-api.herokuapp.com/users"
    }
    
    func fetchUsers(completion: ((Result<[User]?, Error>) -> Void)?) {
        
        guard let url = URL(string: Constants.userUrl.rawValue) else { return }
        
        
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            print(data)
            print(response)
            print(error)
            
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            if let infos = try? decoder.decode([User].self, from: data) {
                print(infos)
//                completion?(infos, nil)
                completion?(.success(infos))
            }
        }
        
        task.resume()
    }
}

