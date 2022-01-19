import Foundation

// MARK: - Domains
struct Domains: Codable {
    let domains: [Domain]?
    let total: Int?
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        case domains, total, time
    }
}

struct Domain: Codable {
    let domain: String?
    let createDate: String?
    let updateDate: String?
    let country: String?
    let isDead: String?
    let a, ns: [String]?
    let mx: [MX]?

    enum CodingKeys: String, CodingKey {
        case domain
        case createDate = "create_date"
        case updateDate = "update_date"
        case country, isDead
        case a = "A"
        case ns = "NS"
        case mx = "MX"
    }
}


// MARK: - MX
struct MX: Codable {
    let exchange: String?
    let priority: Int?
}
