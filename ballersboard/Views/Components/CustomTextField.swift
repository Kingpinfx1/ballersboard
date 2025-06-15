//
//  CustomTextField.swift
//  ballersboard
//
//  Created by kingpin on 6/15/25.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(CustomTextFieldStyle())
        }
    }
}


#Preview {
    CustomTextField(title: "email", text: .constant(""), placeholder: "enter your mail")
}
