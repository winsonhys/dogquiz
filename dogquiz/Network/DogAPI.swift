import Foundation
import Moya

enum DogAPI {
    case getAllBreeds
    case getRandomImages(count: Int)
}

extension DogAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dog.ceo/api")!
    }
    
    var path: String {
        switch self {
        case .getAllBreeds:
            return "/breeds/list/all"
        case .getRandomImages:
            return "/breeds/image/random/3"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getAllBreeds:
            return .requestPlain
        case .getRandomImages(let count):
            return .requestParameters(
                parameters: ["count": count],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    // For testing/debugging
    var sampleData: Data {
        switch self {
        case .getAllBreeds:
            return """
            {
                "message": {
                    "affenpinscher": [],
                    "african": [],
                    "airedale": []
                },
                "status": "success"
            }
            """.data(using: .utf8)!
        case .getRandomImages:
            return """
            {
                "message": [
                    "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
                    "https://images.dog.ceo/breeds/hound-basset/n02088238_13005.jpg",
                    "https://images.dog.ceo/breeds/hound-blood/n02088466_7075.jpg"
                ],
                "status": "success"
            }
            """.data(using: .utf8)!
        }
    }
} 