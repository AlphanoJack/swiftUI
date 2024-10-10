//
//  MySkeletonApp.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI
import Firebase



@main
struct MySkeletonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authController: AuthController
    
    init() {
        let authRepository = FirebaseAuthRepository()
        let authUseCase = AuthUseCaseImpl(authRepository: authRepository)
        
        let userDataRepository = FirestoreUserDataRepository()
        let userDataUseCase = UserDataUseCaseImpl(firestoreUserDataRepository: userDataRepository)
        
        _authController = StateObject(wrappedValue: AuthController(authUseCase: authUseCase, userDataUseCase: userDataUseCase))
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
        }
    }
}
