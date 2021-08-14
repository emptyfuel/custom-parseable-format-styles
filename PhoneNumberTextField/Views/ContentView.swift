//
//  ContentView.swift
//  PhoneNumberTextField
//
//  Created by Mark Thormann on 7/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var phoneNumber = PhoneNumber(areaCode: "617", exchange: "555", number: "1212")
    
    var body: some View {
        ZStack {
            PhoneNumberTextField(phoneNumber: $phoneNumber)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }

}
