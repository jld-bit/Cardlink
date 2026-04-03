import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var purchaseManager: PurchaseManager

    @State private var isBuying = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("CardLink Free vs Premium")
                    .font(.title3.bold())

                FeatureRow(feature: "Profiles", freeValue: "1", premiumValue: "Unlimited")
                FeatureRow(feature: "Themes", freeValue: "Basic", premiumValue: "All + custom colors")
                FeatureRow(feature: "Sharing", freeValue: "Link + QR", premiumValue: "Link + QR")

                if purchaseManager.isPremium {
                    Label("Premium Active", systemImage: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                        .font(.headline)
                } else {
                    Button {
                        Task {
                            isBuying = true
                            defer { isBuying = false }
                            do {
                                try await purchaseManager.purchasePremium()
                            } catch {
                                errorMessage = error.localizedDescription
                            }
                        }
                    } label: {
                        Label("Upgrade to Premium", systemImage: "sparkles")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isBuying)
                }

                if let errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                Spacer()
            }
            .padding()
            .task {
                await purchaseManager.refreshEntitlements()
            }
            .navigationTitle("Premium")
        }
    }
}

private struct FeatureRow: View {
    let feature: String
    let freeValue: String
    let premiumValue: String

    var body: some View {
        HStack {
            Text(feature)
            Spacer()
            Text("Free: \(freeValue)")
            Text("Premium: \(premiumValue)")
                .fontWeight(.semibold)
        }
        .font(.subheadline)
    }
}
