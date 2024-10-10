//
//  ProfileView.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authController: AuthController
    
    var body: some View {
        if let user = authController.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.nickname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .tint(.gray)
                        }
                    }
                }
                Section("General") {
                    
                        SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray), version: "1.0.0")
                    
                }
                Section("Account") {
                    Button {
                        Task {
                            await authController.signOut()
                            print("sign out user...")
                        }
                    } label: {
                        SettingRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red, version: "")
                    }
                    Button {
                        print("delete account...")
                    } label: {
                        SettingRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red, version: "")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
