//
//  Untitled.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/10/24.
//


import FirebaseFirestore
import FirebaseAuth

enum ErrorCase: Error {
    case userDataNotFount
    case decodingError
}

protocol UserDataRepository {
    func fetchUser(uid: String) async throws -> UserModel
    
    func saveUserToFirestore(_ user: UserModel) async throws
}


class FirestoreUserDataRepository: UserDataRepository {
    func fetchUser(uid: String) async throws -> UserModel {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        guard let data = snapshot.data() else {
            throw ErrorCase.userDataNotFount
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(UserModel.self, from: jsonData)
        } catch {
            throw ErrorCase.decodingError
        }
    }
    
    func saveUserToFirestore(_ user: UserModel) async throws {
        let encodedUser = try Firestore.Encoder().encode(user)
        return try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
