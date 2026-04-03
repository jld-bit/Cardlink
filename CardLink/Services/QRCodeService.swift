import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

final class QRCodeService {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    func generate(from text: String) -> Image {
        guard let image = generateUIImage(from: text) else {
            return Image(systemName: "qrcode")
        }
        return Image(uiImage: image)
    }

    func generateUIImage(from text: String) -> UIImage? {
        filter.setValue(Data(text.utf8), forKey: "inputMessage")
        guard let outputImage = filter.outputImage,
              let cgImage = context.createCGImage(outputImage.transformed(by: CGAffineTransform(scaleX: 12, y: 12)), from: outputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }

    func writePNGToTemporaryURL(from text: String) -> URL? {
        guard let image = generateUIImage(from: text),
              let data = image.pngData() else {
            return nil
        }

        let url = FileManager.default.temporaryDirectory.appendingPathComponent("cardlink-qr-\(UUID().uuidString).png")
        try? data.write(to: url)
        return url
    }
}
