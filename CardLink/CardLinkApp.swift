import SwiftUI

@main
struct CardLinkApp: App {
    @StateObject private var purchaseManager = PurchaseManager()
    @StateObject private var profileStore = ProfileStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(purchaseManager)
                .environmentObject(profileStore)
        }
    }
}
