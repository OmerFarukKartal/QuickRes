//
//  LoginModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 22.11.2023.
//

import Foundation
// Kullanıcı adı ve şifre bilgilerini içeren model
struct LoginModel: Codable {
    let Email: String?
    let Password: String?
}
