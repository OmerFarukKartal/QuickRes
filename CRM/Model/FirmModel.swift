//
//  FirmModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 22.11.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//


import Foundation

// MARK: - Firm
struct FirmResponse: Decodable {
    let data: [Firm]
    let success: Bool
    let message: String?
}

// MARK: - Datum
struct Firm: Decodable {
    let id, activityAreaID, businessTypeID, cityID: Int?
    let name: String
    let mapLocation: String?
    let adress, district, postCode, phone: String
    let email, webSite, taxNumber: String
    let taxOffice: String?
    let foundingDate: String
    let linkedin, instagram: String
    let numberOfEmployees: Int
    let description: String?
    let status, isCustomer, isSupplier: Bool
    let activityArea, businessType, city: FirmDetail

    enum CodingKeys: String, CodingKey {
        case id
        case activityAreaID = "activityAreaId"
        case businessTypeID = "businessTypeId"
        case cityID = "cityId"
        case name, mapLocation, adress, district, postCode, phone, email, webSite, taxNumber, taxOffice, foundingDate, linkedin, instagram, numberOfEmployees, description, status, isCustomer, isSupplier, activityArea, businessType, city
    }
}
struct FirmDeleteResponse : Decodable {
    let data: Firm?
    let success: Bool?
    let message: String?
}

// MARK: - ActivityArea
struct FirmDetail: Codable {
    let id: Int
    let description: String
    let status: Bool
}
