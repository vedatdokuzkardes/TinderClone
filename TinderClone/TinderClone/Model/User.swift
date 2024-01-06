//
//  User.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 13.12.2023.
//

import Foundation
import Firebase

struct User : Identifiable, Codable, Hashable {
    
    let id: String
    let email: String
    let name: String
    var age: Int?
    var bio: String?
    var profileImageUrl: String?
    var gender: String = TinderGender.unspecified.rawValue
    var preference: String = TinderGender.unspecified.rawValue
    var interests: Array<String> = []
    var swipesLeft: Array<String> = []
    var swipesRight: Array<String> = []
    var matches: Array<String> = []
    
    static let mockUsers: [User] = [
        .init(id: NSUUID().uuidString, email: "tom@gmail.com", name: "tom", age: 23, bio: "tom bio", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/tindercloneswift.appspot.com/o/images%2F35036D76-A9D5-475D-8C5D-61088A670340?alt=media&token=f7624c8f-2499-4bdf-910f-b4d45f8ebda3", gender: "man", preference: "women", interests: ["skiing", "bicycles", "painting", "astrology"]),
        .init(id: NSUUID().uuidString, email: "u2@gmail.com", name: "u2", age: 29, bio: "u2bio", profileImageUrl: "man1"),
        .init(id: NSUUID().uuidString, email: "u3@gmail.com", name: "u3", age: 29, bio: "u3bio", profileImageUrl: "man3"),
        .init(id: NSUUID().uuidString, email: "u4@gmail.com", name: "u4", age: 29, bio: "u4bio", profileImageUrl: "man4"),
        .init(id: NSUUID().uuidString, email: "u5@gmail.com", name: "u5", age: 29, bio: "u5bio", profileImageUrl: "man5"),
        .init(id: NSUUID().uuidString, email: "u6@gmail.com", name: "u6", age: 29, bio: "u6bio", profileImageUrl: "woman1"),
        .init(id: NSUUID().uuidString, email: "u7@gmail.com", name: "u7", age: 29, bio: "u7bio", profileImageUrl: "woman2"),
        .init(id: NSUUID().uuidString, email: "u8@gmail.com", name: "u8", age: 29, bio: "u8bio", profileImageUrl: "woman3"),
        .init(id: NSUUID().uuidString, email: "u9@gmail.com", name: "u9", age: 29, bio: "u9bio", profileImageUrl: "woman4"),
        .init(id: NSUUID().uuidString, email: "u10@gmail.com", name: "Carol", age: 29, bio: "u10bio", profileImageUrl: "woman5"),
        ]
}

