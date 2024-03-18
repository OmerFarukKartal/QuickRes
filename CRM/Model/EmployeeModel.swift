// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let employee = try? JSONDecoder().decode(Employee.self, from: jsonData)

import Foundation

struct EmployeeListModel: Codable {
    let data: [EmployeeModel]?
    let success: Bool?
    let message: String?
}
// MARK: - Employee
// EmployeeQuireyResponseModel
struct Employee: Codable {
    let data: EmployeeModel?
    let success: Bool?
    let message: String?
}

// MARK: - DataClass
struct EmployeeModel: Codable {
    let id: Int?
    let name, surname, email, phone: String?
    let tckn, adress: String?
    let imageURL: String?
    let workTitle: String?

    enum CodingKeys: String, CodingKey {
        case id, name, surname, email, phone, tckn, adress
        case imageURL = "imageUrl"
        case workTitle
    }
}
