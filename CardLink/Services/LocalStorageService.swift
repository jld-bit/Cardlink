import Foundation

protocol LocalStorageServicing {
    func save(profiles: [CardProfile])
    func loadProfiles() -> [CardProfile]
    func saveOnboardingSeen(_ seen: Bool)
    func hasSeenOnboarding() -> Bool
}

final class LocalStorageService: LocalStorageServicing {
    private enum Keys {
        static let profiles = "cardlink_profiles"
        static let onboarding = "cardlink_onboarding_seen"
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func save(profiles: [CardProfile]) {
        guard let data = try? JSONEncoder().encode(profiles) else { return }
        defaults.set(data, forKey: Keys.profiles)
    }

    func loadProfiles() -> [CardProfile] {
        guard let data = defaults.data(forKey: Keys.profiles),
              let profiles = try? JSONDecoder().decode([CardProfile].self, from: data) else {
            return []
        }
        return profiles
    }

    func saveOnboardingSeen(_ seen: Bool) {
        defaults.set(seen, forKey: Keys.onboarding)
    }

    func hasSeenOnboarding() -> Bool {
        defaults.bool(forKey: Keys.onboarding)
    }
}
