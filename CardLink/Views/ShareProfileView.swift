import SwiftUI

struct ShareProfileView: View {
    @EnvironmentObject private var profileStore: ProfileStore
    private let qrService = QRCodeService()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let profile = profileStore.selectedProfile {
                    Text("Share \(profile.fullName)")
                        .font(.title2.bold())

                    qrService.generate(from: profile.shareURLString)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 20))

                    ShareLink(item: profile.shareURLString) {
                        Label("Share Link", systemImage: "link")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    if let qrURL = qrService.writePNGToTemporaryURL(from: profile.shareURLString) {
                        ShareLink(item: qrURL) {
                            Label("Share QR Image", systemImage: "square.and.arrow.up")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    ContentUnavailableView("No Card Yet", systemImage: "person.crop.circle.badge.exclamationmark", description: Text("Create your first card to start sharing."))
                }
            }
            .padding()
            .navigationTitle("Share")
        }
    }
}
