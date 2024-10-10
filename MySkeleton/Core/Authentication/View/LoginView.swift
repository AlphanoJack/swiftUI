//
//  LoginView.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        NavigationStack {
            VStack {
                // image
                Image("kimberry-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .padding(.vertical, 32)
                //form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button
                
                SignUPAndINButtonView(buttonLabel: "Sign In") {
                    do {
                        try await authController.signIn(withEmail: email, password: password)
                    } catch {
                        print("Error sign in: \(error.localizedDescription)")
                    }
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                
                Spacer()
                
                //sign up button
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 4) {
                        Text("Don'have an accont?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}


// formField 유효성 검사 
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count >= 8
    }
}

#Preview {
    LoginView()
}
