//
//  AuthUseCase.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/10/24.
//
import FirebaseAuth

protocol AuthUseCase {
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User
    func createUser(email: String, password: String) async throws -> FirebaseAuth.User
    func signOut() async throws
}

class AuthUseCaseImpl: AuthUseCase {
    private let authRepository: AuthRepository
    
    init (authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User {
        return try await authRepository.signIn(email: email, password: password)
    }
    func createUser(email: String, password: String) async throws -> FirebaseAuth.User {
        return try await authRepository.createUser(email: email, password: password)
    }
    
    func signOut() async throws {
        try await authRepository.signOut()
    }
}
