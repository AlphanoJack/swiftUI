//
//  UserModel.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let email: String
    let name: String
    let nickname: String

    
    init(id: String = UUID().uuidString, email: String, name: String, nickname: String) {
        self.id = id
        self.email = email
        self.name = name
        self.nickname = nickname
    }
}

extension UserModel {
    static var mockUser: UserModel {
        UserModel(
            id: NSUUID().uuidString,
            email: "test@example.com",
            name: "홍길동",
            nickname: "상큼한 고양이"
        )
    }
}
