
import XCTest
import SwiftAdvance

final class SwiftAdvanceIntegrationTests: XCTestCase {
    // ResultAdvance integration test
    func testResultAdvancePropertiesAndCallbacks() {
        let result: Result<Int, TestError> = .success(42)
        XCTAssertTrue(result.isSuccess)
        XCTAssertFalse(result.isFailure)
        XCTAssertEqual(result.success, 42)
        XCTAssertNil(result.failure)

        let errorResult: Result<Int, TestError> = .failure(.sample)
        XCTAssertTrue(errorResult.isFailure)
        XCTAssertFalse(errorResult.isSuccess)
        XCTAssertEqual(errorResult.failure, .sample)
        XCTAssertNil(errorResult.success)

        var onSuccessCalled = false
        var onFailureCalled = false
        result.onSuccess { value in
            onSuccessCalled = (value == 42)
        }.onFailure { _ in
            onFailureCalled = true
        }
        XCTAssertTrue(onSuccessCalled)
        XCTAssertFalse(onFailureCalled)
    }

    // CodableAdvance integration test
    func testCodableAdvanceEncodingDecoding() throws {
        struct User: Codable, Equatable {
            let id: Int
            let name: String
        }

        let user = User(id: 1, name: "John")
        let data = try user.encodedData()
        let decodedUser = try User(data: data)
        XCTAssertEqual(user, decodedUser)

        let dict = try user.encodedDictionary()
        let userFromDict = try User(dictionary: dict)
        XCTAssertEqual(user, userFromDict)

        let users = [user, User(id: 2, name: "Mary")]
        let jsonString = try users.encodedString()
        XCTAssertTrue(jsonString.contains("John"))
        XCTAssertTrue(jsonString.contains("Mary"))

        // Test compact decoding (skip invalid)
        let invalidArrayJson = """
        [
            {"id": 1, "name": "John"},
            {"invalid": true},
            {"id": 2, "name": "Mary"}
        ]
        """.data(using: .utf8)!
        let validUsers = try [User](data: invalidArrayJson, withCompactDecode: true)
        XCTAssertEqual(validUsers.count, 2)
    }

    // CollectionAdvance integration test
    func testCollectionAdvanceArrayExtensions() {
        let array = [1, 2, 2, 3, 3, 3]
        let noDuplicates = array.removedDuplicates()
        XCTAssertEqual(noDuplicates, [1, 2, 3])

        let grouped = array.grouped { $0 }
        XCTAssertEqual(grouped[2], [2, 2])
        XCTAssertEqual(grouped[3], [3, 3, 3])

        var mutableArray = [1, 2, 3]
        mutableArray.prepend(0)
        XCTAssertEqual(mutableArray, [0, 1, 2, 3])

        // Safe subscript
        XCTAssertEqual(array[optional: 0], 1)
        XCTAssertNil(array[optional: 100])
    }
}

enum TestError: Error, Equatable {
    case sample
}
