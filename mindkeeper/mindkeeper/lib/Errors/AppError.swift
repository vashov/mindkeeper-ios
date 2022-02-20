import Foundation

enum AppError: Error, LocalizedError {
    case someError(String)
    
    var errorDescription: String? {
            switch self {
            case .someError(let msg):
                return msg
            }
        }
}
