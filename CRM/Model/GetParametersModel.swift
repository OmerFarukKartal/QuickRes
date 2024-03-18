//
//  GetParametersModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 15.12.2023.
//

import Foundation

struct GetParametersModel: Codable {
    let data: [GetParameters]?
    let success: Bool?
    let message: String?
}

// MARK: - GetFirmAreaModel
struct GetParameters: Codable {
    let id: Int?
    let description: String?
    let status: Bool?
}
