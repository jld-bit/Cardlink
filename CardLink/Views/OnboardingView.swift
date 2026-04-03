import PhotosUI
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var profileStore: ProfileStore

    @State private var draft = CardProfile()
    @State private var selectedPhoto: PhotosPickerItem?

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple.opacity(0.75), .blue.opacity(0.65)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        Text("Create your first CardLink")
                            .font(.title.bold())
                            .foregroundStyle(.white)

                        ProfileEditorCard(draft: $draft, selectedPhoto: $selectedPhoto, allowThemeCustomization: true)

                        Button("Start Sharing") {
                            profileStore.upsert(draft)
                            profileStore.markOnboardingSeen()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.white)
                        .foregroundStyle(.purple)
                        .disabled(draft.fullName.isEmpty || draft.jobTitle.isEmpty)
                    }
                    .padding()
                }
            }
        }
    }
}
