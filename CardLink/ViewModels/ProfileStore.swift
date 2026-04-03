import Foundation

@MainActor
final class ProfileStore: ObservableObject {
    @Published var profiles: [CardProfile]
    @Published var selectedProfileID: UUID?
    @Published var hasSeenOnboarding: Bool

    private let storage: LocalStorageServicing

    init(storage: LocalStorageServicing = LocalStorageService()) {
        self.storage = storage
        self.profiles = storage.loadProfiles()
        self.selectedProfileID = storage.loadProfiles().first?.id
        self.hasSeenOnboarding = storage.hasSeenOnboarding()
    }

    var selectedProfile: CardProfile? {
        get {
            guard let selectedProfileID else { return profiles.first }
            return profiles.first(where: { $0.id == selectedProfileID })
        }
        set {
            guard let newValue,
                  let index = profiles.firstIndex(where: { $0.id == newValue.id }) else { return }
            profiles[index] = newValue
            persist()
        }
    }

    func upsert(_ profile: CardProfile) {
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles[index] = profile
        } else {
            profiles.append(profile)
        }
        selectedProfileID = profile.id
        persist()
    }

    func canCreateProfile(isPremium: Bool) -> Bool {
        isPremium || profiles.count < 1
    }

    func deleteProfiles(at offsets: IndexSet) {
        profiles.remove(atOffsets: offsets)
        selectedProfileID = profiles.first?.id
        persist()
    }

    func markOnboardingSeen() {
        hasSeenOnboarding = true
        storage.saveOnboardingSeen(true)
    }

    private func persist() {
        storage.save(profiles: profiles)
    }
}
