import PhotosUI
import SwiftUI

struct ProfileEditorCard: View {
    @Binding var draft: CardProfile
    @Binding var selectedPhoto: PhotosPickerItem?
    let allowThemeCustomization: Bool

    var body: some View {
        VStack(spacing: 14) {
            PhotosPicker(selection: $selectedPhoto, matching: .images) {
                Label("Add Photo", systemImage: "camera.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .onChange(of: selectedPhoto) { _, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        draft.photoData = data
                    }
                }
            }

            Group {
                TextField("Full Name", text: $draft.fullName)
                TextField("Job Title", text: $draft.jobTitle)
                TextField("Email", text: $draft.email)
                    .textInputAutocapitalization(.never)
                TextField("Phone", text: $draft.phone)
                TextField("Website", text: $draft.website)
                    .textInputAutocapitalization(.never)
                TextField("Social Handle", text: $draft.socialHandle)
            }
            .textFieldStyle(.roundedBorder)

            Picker("Theme", selection: $draft.theme) {
                ForEach(ProfileTheme.allCases) { theme in
                    Text(theme.displayName).tag(theme)
                }
            }
            .pickerStyle(.segmented)
            .disabled(!allowThemeCustomization)

            if !allowThemeCustomization {
                Text("Premium unlocks extra themes and custom colors.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(.systemBackground).opacity(0.9))
        )
    }
}
