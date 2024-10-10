//
//  AuthViewModel.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}
@MainActor
class AuthController: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    
    private let authUseCase: AuthUseCase
    private let userDataUseCase: UserDataUseCase
    
    init(authUseCase: AuthUseCase, userDataUseCase: UserDataUseCase) {
        self.authUseCase = authUseCase
        self.userDataUseCase = userDataUseCase
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await authUseCase.signIn(email: email, password: password)
            self.userSession = result
            await fetchUser()
        } catch {
            print(("DEBUG: Failed to login with errir \(error.localizedDescription)"))
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String, nickname: String) async throws {
        do {
            // Firebase Authentication을 사용하여 유저를 생성
            let result = try await authUseCase.createUser(email: email, password: password)
            self.userSession = result
            
            // UserModel 인스턴스 생성
            let user = UserModel(id: result.uid, email: email, name: name, nickname: nickname)
            
            // 생성된 유저를 DB에 저장
            try await userDataUseCase.saveUser(user)
            
            // 유저정보 가져오기 
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    
    func signOut () async {
        do {
            try await authUseCase.signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteUser() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            self.currentUser = try await userDataUseCase.fetchUser(uid: uid)
        } catch {
            print("Error fetching user: \(error)")
        }
        
    }
}
