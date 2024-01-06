//
//  Message.swift
//  TinderClone
//
//  Created by Vedat Dokuzkardeş on 3.01.2024.
//

import Foundation
import Firebase

struct Message: Identifiable, Codable, Hashable{
    
    var id: String = NSUUID().uuidString
    let sentBy: String
    let text: String
    let timestamp: Timestamp
}
