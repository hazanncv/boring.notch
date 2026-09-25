//
//  TabButton.swift
//  boringNotch
//
//  Created by Hugo Persson on 2024-08-24.
//

import Defaults
import SwiftUI

struct TabButton: View {
    let label: String
    let icon: String
    let selected: Bool
    let onClick: () -> Void
    @Default(.canNewDesign) var canNewDesign

    var body: some View {
        Button(action: onClick) {
            if canNewDesign {
                HStack(spacing: 5) {
                    Image(systemName: icon)
                        .imageScale(.small)
                    Text(label)
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .contentShape(Capsule())
            } else {
                Image(systemName: icon)
                    .padding(.horizontal, 15)
                    .contentShape(Capsule())
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview("Default") {
    HStack {
        TabButton(label: "Home", icon: "house.fill", selected: true) { }
        TabButton(label: "Shelf", icon: "tray.fill", selected: false) { }
    }
    .padding()
    .background(.black)
}

#Preview("New Design") {
    HStack {
        TabButton(label: "Nook", icon: "scope", selected: true) { }
        TabButton(label: "Tray", icon: "headphones", selected: false) { }
    }
    .padding()
    .background(.black)
    .onAppear { Defaults[.canNewDesign] = true }
}
