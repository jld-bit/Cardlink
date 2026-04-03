import Foundation
import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {
    @Published private(set) var isPremium = false

    let premiumProductID = "com.cardlink.premium.monthly"

    func refreshEntitlements() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            if transaction.productID == premiumProductID {
                isPremium = true
                return
            }
        }
        isPremium = false
    }

    func purchasePremium() async throws {
        guard let product = try await Product.products(for: [premiumProductID]).first else {
            return
        }

        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            guard case .verified(let transaction) = verification else { return }
            isPremium = true
            await transaction.finish()
        default:
            break
        }
    }
}
