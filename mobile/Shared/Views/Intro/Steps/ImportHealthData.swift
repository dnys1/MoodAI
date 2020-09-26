//
//  ImportHealthData.swift
//  MoodAI
//
//  Created by Dillon Nys on 9/3/20.
//

import SwiftUI

struct ImportHealthData: View {
    @Environment(\.theme) var theme
    
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("Import Health Data")
                    .font(.title)
                    .foregroundColor(theme.white)
            }.padding()
            
            Button(action: {}) {
                HStack {
                    Text("Privacy Policy")
                        .foregroundColor(theme.white)
                    Image(systemName: "info.circle")
                        .foregroundColor(theme.white)
                }
            }.padding()
        }
    }
}

struct ImportHealthData_Previews: PreviewProvider {
    static var previews: some View {
        ImportHealthData()
    }
}
