//
//  RegistrationView.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State private var name: String = ""
    @State private var nickname: String = ""
    @State private var age: String = ""
    
    @State private var currentStep: RegistrationStep = .email
    
    enum RegistrationStep: Int, CaseIterable {
        case email = 0, name, nickname, age, password, passwordConfirm
    }
    
    var body: some View {
        VStack {
            // image
            Image("kimberry-logo")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                ScrollView {
                    VStack(spacing: 24) {
                        ForEach(RegistrationStep.allCases.reversed(), id: \.self) { step in
                            if currentStep.rawValue >= step.rawValue {
                                inputField(for: step)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
        }
        .onChange(of: [email, name, nickname, age, password, passwordConfirm]) { _, _ in
            updateCurrentStep()
        }
    }
    
    @ViewBuilder
    private func inputField(for step: RegistrationStep) -> some View {
        switch step {
        case .email:
            InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                .autocapitalization(.none)
        case .name:
            InputView(text: $name, title: "Name", placeholder: "홍길동")
                .autocapitalization(.none)
        case .nickname:
            InputView(text: $nickname, title: "Nickname", placeholder: "상큼한 고양이")
                .autocapitalization(.none)
        case .age:
            InputView(text: $age, title: "Age", placeholder: "20")
                .autocapitalization(.none)
        case .password:
            InputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
        case .passwordConfirm:
            InputView(text: $passwordConfirm, title: "Password Confirm", placeholder: "password confirm", isSecureField: true)
        }
    }
    
    private func updateCurrentStep() {
        switch currentStep {
        case .email where !email.isEmpty:
            currentStep = .name
        case .name where !name.isEmpty:
            currentStep = .nickname
        case .nickname where !nickname.isEmpty:
            currentStep = .age
        case .age where !age.isEmpty:
            currentStep = .password
        case .password where !password.isEmpty:
            currentStep = .passwordConfirm
        default:
            break
        }
    }
}

#Preview {
    RegistrationView()
}
