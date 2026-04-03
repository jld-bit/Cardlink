import SwiftUI

struct RootView: View {
    @EnvironmentObject private var profileStore: ProfileStore

    var body: some View {
        Group {
            if profileStore.hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}
