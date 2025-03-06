import Foundation

struct BreedsResponse: Codable {
    let message: [String: [String]]
    let status: String
}

struct RandomImagesResponse: Codable {
    let message: [String]
    let status: String
} 