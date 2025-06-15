//
//  CustomSecureField.swift
//  ballersboard
//
//  Created by kingpin on 6/15/25.
//

import SwiftUI

struct CustomSecureField: View {
    let title: String
    @Binding var text: String
    
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            SecureField(placeholder, text: $text)
                .textFieldStyle(CustomTextFieldStyle())
        }
    }
}

#Preview {
    CustomSecureField(title: "title", text: .constant(""), placeholder: "secure")
}
