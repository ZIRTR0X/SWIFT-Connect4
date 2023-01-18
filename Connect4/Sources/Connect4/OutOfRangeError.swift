import Foundation

struct OutOfRangeError: Error {
    let message: String
    init(_ message: String) {
        self.message = "Error : " + message
    }
}
