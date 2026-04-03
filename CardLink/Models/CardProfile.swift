import Foundation

struct CardProfile: Identifiable, Codable, Equatable {
    var id: UUID
    var fullName: String
    var jobTitle: String
    var photoData: Data?
    var email: String
    var phone: String
    var website: String
    var socialHandle: String
    var customColorHex: String?
    var theme: ProfileTheme

    init(
        id: UUID = UUID(),
        fullName: String = "",
        jobTitle: String = "",
        photoData: Data? = nil,
        email: String = "",
        phone: String = "",
        website: String = "",
        socialHandle: String = "",
        customColorHex: String? = nil,
        theme: ProfileTheme = .sunrise
    ) {
        self.id = id
        self.fullName = fullName
        self.jobTitle = jobTitle
        self.photoData = photoData
        self.email = email
        self.phone = phone
        self.website = website
        self.socialHandle = socialHandle
        self.customColorHex = customColorHex
        self.theme = theme
    }

    var shareURLString: String {
        "cardlink://profile/\(id.uuidString)"
    }

    static let preview = CardProfile(
        fullName: "Alex Rivera",
        jobTitle: "Product Designer",
        email: "alex@cardlink.example",
        phone: "+1 (555) 123-4567",
        website: "https://cardlink.example/alex",
        socialHandle: "@alexdesigns",
        theme: .aurora
    )
}

enum ProfileTheme: String, CaseIterable, Codable, Identifiable {
    case sunrise
    case aurora
    case ocean

    var id: String { rawValue }
    var displayName: String {
        switch self {
        case .sunrise: return "Sunrise"
        case .aurora: return "Aurora"
        case .ocean: return "Ocean"
        }
    }
}
