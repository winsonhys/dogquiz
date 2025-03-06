import XCTest
import Moya
@testable import dogquiz

final class DogServiceTests: XCTestCase {
    var sut: DogService!
    var provider: MoyaProvider<DogAPI>!
    
    override func setUp() {
        super.setUp()
        // Create a test provider that uses the sampleData from our DogAPI
        provider = MoyaProvider<DogAPI>(stubClosure: MoyaProvider.immediatelyStub)
        sut = DogService(provider: provider)
    }
    
    override func tearDown() {
        sut = nil
        provider = nil
        super.tearDown()
    }
    
    func testFetchAllBreeds() async throws {
        // When
        let response = try await sut.fetchAllBreeds()
        
        // Then
        XCTAssertEqual(response.status, "success")
        XCTAssertFalse(response.message.isEmpty)
        XCTAssertNotNil(response.message["affenpinscher"])
        XCTAssertNotNil(response.message["african"])
        XCTAssertNotNil(response.message["airedale"])
    }
    
    func testFetchRandomImages() async throws {
        // When
        let response = try await sut.fetchRandomImages(count: 3)
        
        // Then
        XCTAssertEqual(response.status, "success")
        XCTAssertEqual(response.message.count, 3)
        
        // Verify URLs are valid
        for imageUrl in response.message {
            XCTAssertNotNil(URL(string: imageUrl))
            XCTAssertTrue(imageUrl.contains("images.dog.ceo"))
        }
    }
    
    func testFetchAllBreedsFailure() async {
        // Given
        let errorProvider = MoyaProvider<DogAPI>(
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [NetworkErrorPlugin()]
        )
        sut = DogService(provider: errorProvider)
        
        // When/Then
        do {
            _ = try await sut.fetchAllBreeds()
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchRandomImagesFailure() async {
        // Given
        let errorProvider = MoyaProvider<DogAPI>(
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [NetworkErrorPlugin()]
        )
        sut = DogService(provider: errorProvider)
        
        // When/Then
        do {
            _ = try await sut.fetchRandomImages(count: 3)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

// Helper plugin to simulate network errors
private final class NetworkErrorPlugin: PluginType {
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        return .failure(MoyaError.underlying(NSError(domain: "com.dogquiz.error", code: -1, userInfo: nil), nil))
    }
} 
