//
//  PhoneNumberTextField.swift
//  PhoneNumberTextField
//
//  Created by Mark Thormann on 7/31/21.
//

import SwiftUI

/// Example of a `TextField` using the new `format` initializer
struct PhoneNumberTextField: View {

    @Binding var phoneNumber: PhoneNumber
    
    var body: some View {
        TextField("Phone Number", value: $phoneNumber, format: .phoneNumber, prompt: Text("Enter phone number"))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

struct PhoneNumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State var phoneNumber = PhoneNumber(areaCode: "", exchange: "", number: "")
        
        var body: some View {
            ZStack {
                PhoneNumberTextField(phoneNumber: $phoneNumber)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
        }
    }
    
}
