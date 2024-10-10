//
//  UserDataUseCase.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/10/24.
//

protocol UserDataUseCase {
    func fetchUser(uid: String) async throws -> UserModel
    
    func saveUser(_ user: UserModel) async throws
}


class UserDataUseCaseImpl: UserDataUseCase {
    private let firestoreUserDataRepository: FirestoreUserDataRepository
    
    init (firestoreUserDataRepository: FirestoreUserDataRepository) {
        self.firestoreUserDataRepository = firestoreUserDataRepository
    }
    
    func fetchUser(uid: String) async throws -> UserModel {
        return try await firestoreUserDataRepository.fetchUser(uid: uid)
    }
    
    func saveUser(_ user: UserModel) async throws {
        try await firestoreUserDataRepository.saveUserToFirestore(user)
    }
}
