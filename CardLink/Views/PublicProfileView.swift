import SwiftUI

struct PublicProfileView: View {
    let profile: CardProfile

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Circle()
                    .fill(.white.opacity(0.35))
                    .overlay {
                        if let photoData = profile.photoData,
                           let image = UIImage(data: photoData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: 42))
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(width: 94, height: 94)

                Text(profile.fullName)
                    .font(.title.bold())
                    .foregroundStyle(.white)

                Text(profile.jobTitle)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))

                VStack(alignment: .leading, spacing: 10) {
                    ContactRow(title: "Email", value: profile.email, icon: "envelope.fill")
                    ContactRow(title: "Phone", value: profile.phone, icon: "phone.fill")
                    ContactRow(title: "Website", value: profile.website, icon: "globe")
                    ContactRow(title: "Social", value: profile.socialHandle, icon: "at")
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
            }
            .padding()
        }
        .background(themeGradient.ignoresSafeArea())
        .navigationTitle("Public Profile")
    }

    private var themeGradient: LinearGradient {
        switch profile.theme {
        case .sunrise:
            return LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .aurora:
            return LinearGradient(colors: [.purple, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .ocean:
            return LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

private struct ContactRow: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        if !value.isEmpty {
            HStack {
                Image(systemName: icon)
                Text(title + ":")
                    .fontWeight(.semibold)
                Text(value)
                    .lineLimit(1)
            }
            .font(.subheadline)
            .foregroundStyle(.white)
        }
    }
}
