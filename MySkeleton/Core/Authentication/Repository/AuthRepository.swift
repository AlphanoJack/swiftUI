//
//  AuthRepository.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/10/24.
//
import FirebaseAuth

protocol AuthRepository {
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User
    func createUser(email: String, password: String) async throws -> FirebaseAuth.User
    func signOut() async throws
}

class FirebaseAuthRepository: AuthRepository {
    
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    
    func createUser(email: String, password: String) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user
    }
    
    func signOut() async throws {
        try Auth.auth().signOut()
    }
}
