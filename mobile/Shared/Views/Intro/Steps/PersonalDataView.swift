//
//  PersonalDataView.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/20/20.
//

import SwiftUI

struct PersonalDataView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ""
    @State private var age: Int?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Personal Data")
                .font(.title)
                .padding()
            TextField("Name", text: $name)
                .padding()
            Picker("Age", selection: $age, content: {
                ForEach(13..<100) { age in
                    Text("\(age)")
                }
            })
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
            })
            Spacer()
        }
    }
}

struct PersonalDataView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataView()
    }
}
