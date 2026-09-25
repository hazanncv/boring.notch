//
//  TabSelectionView.swift
//  boringNotch
//
//  Created by Hugo Persson on 2024-08-25.
//

import Defaults
import SwiftUI

struct TabModel: Identifiable {
    let id = UUID()
    let label: String
    let icon: String
    let view: NotchViews
}

private let defaultTabs = [
    TabModel(label: "Home", icon: "house.fill", view: .home),
    TabModel(label: "Shelf", icon: "tray.fill", view: .shelf)
]

private let nookTabs = [
    TabModel(label: "Nook", icon: "scope", view: .home),
    TabModel(label: "Tray", icon: "headphones", view: .shelf)
]

struct TabSelectionView: View {
    @ObservedObject var coordinator = BoringViewCoordinator.shared
    @Default(.canNewDesign) var canNewDesign
    @Namespace var animation

    private var activeTabs: [TabModel] { canNewDesign ? nookTabs : defaultTabs }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(activeTabs) { tab in
                TabButton(label: tab.label, icon: tab.icon, selected: coordinator.currentView == tab.view) {
                    withAnimation(.smooth) {
                        coordinator.currentView = tab.view
                    }
                }
                .frame(height: 26)
                .foregroundStyle(tab.view == coordinator.currentView ? .white : .gray)
                .background {
                    if tab.view == coordinator.currentView {
                        Capsule()
                            .fill(coordinator.currentView == tab.view ? Color(nsColor: .secondarySystemFill) : Color.clear)
                            .matchedGeometryEffect(id: "capsule", in: animation)
                    } else {
                        Capsule()
                            .fill(coordinator.currentView == tab.view ? Color(nsColor: .secondarySystemFill) : Color.clear)
                            .matchedGeometryEffect(id: "capsule", in: animation)
                            .hidden()
                    }
                }
            }
        }
        .clipShape(Capsule())
    }
}

#Preview {
    BoringHeader().environmentObject(BoringViewModel())
}
