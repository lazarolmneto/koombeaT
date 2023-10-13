//
//  User.swift
//  KoombeaT
//
//  Created by Lazaro Neto on 13/10/23.
//

import Foundation

//"id": 1,
//   "firstName": "John",
//   "lastName": "Appleseed",
//   "username": "john.appleseed",
//   "email": "john.appleseed@mac.com",
//   "gender": "male",
//   "pictureURL": "https://randomuser.me/api/portraits/men/1.jpg",
//   "phone": "(888) 555-5512",
//   "birthday": "1980-06-22",
//   "twitterHandle": "@johnappleseed"


struct User: Codable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let gender: String
    let pictureURL: String
    let phone: String
    let birthday: String
    let twitterHandle: String
}
