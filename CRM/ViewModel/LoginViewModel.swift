import Foundation

struct LoginResponse: Decodable {
    let data: TokenData
    let success: Bool
    let message: String?
}

struct TokenData: Decodable {
    let token: AccessToken
    let userId: Int
}

struct AccessToken: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiration: String
}
