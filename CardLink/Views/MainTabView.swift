import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ProfilesListView()
                .tabItem {
                    Label("Cards", systemImage: "person.text.rectangle")
                }

            ShareProfileView()
                .tabItem {
                    Label("Share", systemImage: "qrcode")
                }

            SettingsView()
                .tabItem {
                    Label("Premium", systemImage: "sparkles")
                }
        }
    }
}
