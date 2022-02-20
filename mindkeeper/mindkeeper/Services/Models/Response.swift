import Foundation

public class Response : Decodable {
    public let status: Int
    public let succeeded: Bool
    public let message: String?
}

public class ResponseData<T: Decodable> : Decodable {
    public let status: Int
    public let succeeded: Bool
    public let message: String?
    public let data: T
}
