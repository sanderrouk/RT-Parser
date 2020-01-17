import Vapor
import XCTest

public func XCTAssertThrowsAbortError<T>(
    withStatus status: HTTPResponseStatus,
    _ expression: @autoclosure () throws -> T
) {
    XCTAssertThrowsError(expression) { error in
        if let error = error as? AbortError {
            XCTAssertEqual(error.status, status)
        } else {
            XCTFail("Not an Abort Error")
        }
    }
}
