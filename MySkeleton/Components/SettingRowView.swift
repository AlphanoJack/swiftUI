//
//  SettingRowView.swift
//  MySkeleton
//
//  Created by 서재혁 on 10/9/24.
//

import SwiftUI

struct SettingRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    let version: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.black)
            Spacer()
            Text(version)
                .font(.subheadline)
                .foregroundStyle(Color(.systemGray2))
        }
    }
}

#Preview {
    SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray), version: "1.0.0")
}
