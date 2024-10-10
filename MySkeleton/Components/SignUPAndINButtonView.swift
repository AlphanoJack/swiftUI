//
//  SignUPAndINButtonView.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI

struct SignUPAndINButtonView: View {
    
    let buttonLabel: String
    let buttonAction: () async -> Void
    
    var body: some View {
        Button {
            Task {
                await buttonAction()
            }
            print("click Btn")
        } label: {
            HStack {
                Text(buttonLabel)
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
        .padding(.bottom, 24)
    }
}

#Preview {
    SignUPAndINButtonView(buttonLabel: "demo", buttonAction: {})
}
