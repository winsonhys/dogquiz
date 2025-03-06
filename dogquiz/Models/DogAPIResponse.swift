import Foundation

struct BreedsResponse: Codable {
    let message: [String: [String]]
    let status: String
    
}

struct RandomImagesResponse: Codable {
    let message: [String]
    let status: String
    
    func toDogs() -> [Dog] {
        return message.compactMap { imageUrl in
            // Parse breed from image URL
            // URL format: https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg
            let regex = try! NSRegularExpression(pattern: "/breeds/([^/]+)/")

            
            if let match = regex.firstMatch(in: imageUrl, range: NSRange(imageUrl.startIndex..., in: imageUrl)) {
                if let range = Range(match.range(at: 1), in: imageUrl) {
                    let breed = String(imageUrl[range])
                    return Dog(breed: breed, image: imageUrl)
                }
            }
            
            return Dog(breed: "nil", image: imageUrl)
            
        }
    }
}

