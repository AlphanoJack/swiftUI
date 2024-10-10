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
    
    @State private var currentStep: RegistrationStep = .email
    @State private var showNextField: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authController: AuthController
    
    enum RegistrationStep: Int, CaseIterable {
        case email = 0, name, nickname, password, passwordConfirm, complete
    }
    
    var body: some View {
        VStack {
            
            // image
            
            Image("kimberry-logo")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .padding(.vertical, 32)
            
            // Sign Up Input Fields
            
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
            
            Spacer()
            // Back to Login View
            Button{
                dismiss()
            } label: {
                HStack(spacing: 4) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
        .onChange(of: [email, name, nickname, password, passwordConfirm]) { _, _ in
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
                
        case .password:
            InputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
        case .passwordConfirm:
            InputView(text: $passwordConfirm, title: "Password Confirm", placeholder: "password confirm", isSecureField: true)
        case .complete:
            SignUPAndINButtonView(buttonLabel: "Sign UP") {
                do {
                    try await authController.createUser(withEmail: email, password: password, name: name, nickname: nickname)
                } catch {
                    print("\(email) 회원가입 실패: \(error)")
                }
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1 : 0.3)
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
            nextStep = .password
        case .password where !password.isEmpty:
            nextStep = .passwordConfirm
        case .passwordConfirm:
            nextStep = .complete
        case .complete:
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

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !name.isEmpty
        && name.count > 4
        && !nickname.isEmpty
        && nickname.count > 4
        && !password.isEmpty
        && password.count > 8
        && password == passwordConfirm
    }
}

#Preview {
    RegistrationView()
}
