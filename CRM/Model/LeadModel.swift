import Foundation

// MARK: - LeadResponse
struct LeadResponse: Decodable {
    let data: [Lead]?
    let success: Bool?
    let message: String?
}

// MARK: - Lead
struct Lead: Decodable {
    let id: Int?
    let customerName: String?
    let currencyTypeId, leadTypeId: Int?
    let leadAmount: Double?
    let createDate, resource: String?
    let precedenceId: Int?
    let title, leadDescription: String?
    let userId, leadStatusId: Int?
    let status: Bool?
    let associatedOfferName: String?
    let user: User?
    let leadStatus, leadType, currencyType, precedence: LeadStatus?

    enum CodingKeys: String, CodingKey {
        case id, customerName, currencyTypeId, leadTypeId, leadAmount, createDate, resource, precedenceId, title
        case leadDescription = "description"
        case userId, leadStatusId, status, associatedOfferName, user, leadStatus, leadType, currencyType, precedence
    }
}

// MARK: - LeadStatus
struct LeadStatus: Decodable {
    let id: Int?
    let description: String?
    let status: Bool?
}

// MARK: - User
struct User: Decodable {
    let id, employeId: Int?
    let email: String?
    let securityCode, passwordHash, passwordSalt: String?
    let employe: Employe?
}

// MARK: - Employe
struct Employe: Codable {
    let id: Int
    let name, surname, employeEmail, phone, tckn, adress, imageUrl, workTitle: String

    enum CodingKeys: String, CodingKey {
        case id, name, surname
        case employeEmail = "email"
        case phone, tckn, adress, imageUrl, workTitle
    }
}
