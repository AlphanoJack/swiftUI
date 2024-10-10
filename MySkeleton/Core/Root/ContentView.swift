//
//  ContentView.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        Group {
            if authController.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}


