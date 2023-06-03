//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Nikita Kolomoec on 03.06.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            Text("Please select a resort from a left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
