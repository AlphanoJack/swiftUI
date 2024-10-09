//
//  inputField.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import Foundation
import SwiftUI

struct RegistrationInputField: View {
    @Binding var text: String
    let step: RegistrationView.RegistrationStep
    
    var body: some View {
        switch step {
        case .email:
            InputView(text: $text,title: "Email Address", placeholder: "Email")
        case .name:
            InputView(text: $text,title: "Name", placeholder: "Name")
        case .nickname:
            InputView(text: $text,title: "Nickname", placeholder: "Nickname")
        case .age:
            InputView(text: $text,title: "Age", placeholder: "Age")
        case .password:
            InputView(text: $text,title: "Password", placeholder: "Password", isSecureField: true)
        case .passwordConfirm:
            InputView(text: $text,title: "Password Confirm", placeholder: "Password Confirm", isSecureField: true)
        }
    }
}
