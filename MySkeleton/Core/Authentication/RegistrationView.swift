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
    @State private var showNextField: Bool = false
    
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
                            if step.rawValue <= currentStep.rawValue {
                                inputField(for: step)
                                    .transition(.opacity)
                                    .animation(.easeInOut(duration: 0.5), value: currentStep)
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
                .keyboardType(.emailAddress)
        case .name:
            InputView(text: $name, title: "Name", placeholder: "홍길동")
                .autocapitalization(.none)
        case .nickname:
            InputView(text: $nickname, title: "Nickname", placeholder: "상큼한 고양이")
                .autocapitalization(.none)
        case .age:
            InputView(text: $age, title: "Age", placeholder: "20")
                .autocapitalization(.none)
                .keyboardType(.numberPad)
                
        case .password:
            InputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
        case .passwordConfirm:
            InputView(text: $passwordConfirm, title: "Password Confirm", placeholder: "password confirm", isSecureField: true)
        }
    }
    
    private func updateCurrentStep() {
        let nextStep: RegistrationStep?
        
        switch currentStep {
        case .email where !email.isEmpty:
            nextStep = .name
        case .name where !name.isEmpty:
            nextStep = .nickname
        case .nickname where !nickname.isEmpty:
            nextStep = .age
        case .age where !age.isEmpty:
            nextStep = .password
        case .password where !password.isEmpty:
            nextStep = .passwordConfirm
        case .passwordConfirm:
            nextStep = nil
        default:
            return
        }
        
        if let nextStep = nextStep, nextStep != currentStep {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    currentStep = nextStep
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
