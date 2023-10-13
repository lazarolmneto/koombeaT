//
//  UserRequesterTest.swift
//  KoombeaTTests
//
//  Created by Lazaro Neto on 13/10/23.
//

import Foundation
import XCTest

@testable import KoombeaT

class UserRequesterMock: UserRequest {
    
    func fetchUsers(completion: ((Result<[User]?, Error>) -> Void)?) {
     
        let usersStrJSON = """
        
        [
          {
            "id": 1,
            "firstName": "John",
            "lastName": "Appleseed",
            "username": "john.appleseed",
            "email": "john.appleseed@mac.com",
            "gender": "male",
            "pictureURL": "https://randomuser.me/api/portraits/men/1.jpg",
            "phone": "(888) 555-5512",
            "birthday": "1980-06-22",
            "twitterHandle": "@johnappleseed"
          },
          {
            "id": 2,
            "firstName": "Kate",
            "lastName": "Bell",
            "username": "kate.bell",
            "email": "kate.bell@mac.com",
            "gender": "female",
            "pictureURL": "https://randomuser.me/api/portraits/women/2.jpg",
            "phone": "(555) 564-8583",
            "birthday": "1978-01-20",
            "twitterHandle": "@katebell"
          },
          {
            "id": 3,
            "firstName": "David",
            "lastName": "Tylor",
            "username": "david.taylor",
            "email": "david.taylor@mac.com",
            "gender": "male",
            "pictureURL": "https://randomuser.me/api/portraits/men/3.jpg",
            "phone": "(555) 610-6679",
            "birthday": "1998-06-15",
            "twitterHandle": "@davidtylor"
          },
          {
            "id": 4,
            "firstName": "Anna",
            "lastName": "Haro",
            "username": "anna-haro",
            "email": "anna-haro@mac.com",
            "gender": "female",
            "pictureURL": "https://randomuser.me/api/portraits/women/4.jpg",
            "phone": "(555) 522-8243",
            "birthday": "2002-02-15",
            "twitterHandle": "@annaharo"
          }
        ]

        """
        
        let data = usersStrJSON.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let infos = try decoder.decode([User].self, from: data)
            print(infos)
            completion?(.success(infos))
        }
        catch let error {
            completion?(.failure(error))
        }
        
        
    }
}

final class UserRequesterTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUsers() throws {
        
        let mock = UserRequesterMock()
        
        let expectation = XCTestExpectation(description: "user mock expectation")
        
        var usersAux = [User]()
        
        mock.fetchUsers { result in
            switch result {
            case let .success(users):
                usersAux = users ?? []
            case let .failure(error):
                print(error)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(!usersAux.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
