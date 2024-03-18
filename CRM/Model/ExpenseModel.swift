
import Foundation

// MARK: - Expense
struct Expense: Decodable {
    let data: [ExpenseModel]?
    let success: Bool?
    let message: String?
}

// MARK: - Datum
struct ExpenseModel: Decodable {
    let id, userID: Int?
    let receiptDate, createdDate: String?
    let amount, kdvRate: Int?
    let imageURL: String?
    let expenseCategoryID, receiptTaxNumber, receiptNo: Int?
    let kdvAmount: Double?
    let isConfirmed: Bool?
    let user: ExpenseUser
    let expenseCategory: ExpenseCategory

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case receiptDate, createdDate, amount, kdvRate
        case imageURL = "imageUrl"
        case expenseCategoryID = "expenseCategoryId"
        case receiptTaxNumber, receiptNo, kdvAmount, isConfirmed, user, expenseCategory
    }
}

// MARK: - ExpenseCategory
struct ExpenseCategory: Decodable {
    let id: Int?
    let description: String?
    let status: Bool?
}

// MARK: - User
struct ExpenseUser: Decodable {
    let id, employeID: Int?
    let email: String?
    let securityCode: String?
    let passwordHash, passwordSalt: String?
    let employe: ExpenseEmploye

    enum CodingKeys: String, CodingKey {
        case id
        case employeID = "employeId"
        case email, securityCode, passwordHash, passwordSalt, employe
    }
}

// MARK: - Employe
struct ExpenseEmploye: Decodable {
    let id: Int?
    let name, surname, email, phone: String?
    let tckn, adress, imageURL, workTitle: String?

    enum CodingKeys: String, CodingKey {
        case id, name, surname, email, phone, tckn, adress
        case imageURL = "imageUrl"
        case workTitle
    }
}
