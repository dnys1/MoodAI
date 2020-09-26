//
//  NameView.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/7/20.
//

import SwiftUI

struct NameView: View {
    @Environment(\.theme) var theme
    @EnvironmentObject var user: User
    
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented = true
        }, label: {
            Text("Add Personal Info")
        }).sheet(isPresented: $isPresented, content: {
            PersonalDataView()
        })
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
