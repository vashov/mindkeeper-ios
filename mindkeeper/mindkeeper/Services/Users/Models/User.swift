import Foundation

struct User: Identifiable, Decodable {
    var id: UUID
    var phone: Int
    var givenName: String?
    var familyName: String?
    var about: String?
}
