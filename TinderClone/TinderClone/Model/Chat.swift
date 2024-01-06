//
//  Chat.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 2.01.2024.
//

import Foundation

struct Chat: Identifiable, Codable, Hashable {
    
    let id: String
    let user1: User
    let user2: User
    
    static let mockChats: [Chat] = [
        .init(id: NSUUID().uuidString, user1: User.mockUsers[1], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[2], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[3], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[4], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[5], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[6], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[7], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[8], user2: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, user1: User.mockUsers[9], user2: User.mockUsers[0]),
    ]
}
