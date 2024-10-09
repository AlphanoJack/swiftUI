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
                
                Button {
                    print("LoginView, Log user in ...")
                } label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue)
                    .cornerRadius(10)
                )
                .padding(.top, 24)
                
                Spacer()
                
                //sign up button
                
                NavigationLink{
                    
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

#Preview {
    LoginView()
}
