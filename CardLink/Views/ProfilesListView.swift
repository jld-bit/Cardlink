import PhotosUI
import SwiftUI

struct ProfilesListView: View {
    @EnvironmentObject private var profileStore: ProfileStore
    @EnvironmentObject private var purchaseManager: PurchaseManager

    @State private var showingCreate = false
    @State private var draft = CardProfile()
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var showPremiumAlert = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(profileStore.profiles) { profile in
                    NavigationLink {
                        PublicProfileView(profile: profile)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(profile.fullName).font(.headline)
                            Text(profile.jobTitle).font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: profileStore.deleteProfiles)
            }
            .navigationTitle("Your Cards")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if profileStore.canCreateProfile(isPremium: purchaseManager.isPremium) {
                            draft = CardProfile()
                            showingCreate = true
                        } else {
                            showPremiumAlert = true
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingCreate) {
                NavigationStack {
                    ProfileEditorCard(draft: $draft, selectedPhoto: $selectedPhoto, allowThemeCustomization: purchaseManager.isPremium)
                        .padding()
                        .navigationTitle("New Card")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") { showingCreate = false }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save") {
                                    profileStore.upsert(draft)
                                    showingCreate = false
                                }
                                .disabled(draft.fullName.isEmpty || draft.jobTitle.isEmpty)
                            }
                        }
                }
            }
            .alert("Premium required", isPresented: $showPremiumAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Upgrade to create and save multiple business card profiles.")
            }
        }
    }
}
