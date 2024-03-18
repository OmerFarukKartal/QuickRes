//
//  UpdateEmployeeViewModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 7.12.2023.
//

import Foundation

final class UpdateEmployeeViewModel {
    
    let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func updateEmplyee(Id: Int, name: String, surname: String, email: String, address: String, tckn: String, phone: String) {
        networkManager.updateEmployee(Id: Id, name: name, surname: surname, email: email, address: address, tckn: tckn, phone: phone) { response in
            switch response {
            case .success(let success):
                if success.success == true {
                    print("güncellendi")
                } else {
                    print("güncellenmedi")
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    func updateEmployee(employeeId: Int, name: String, surname: String, email: String, phone: String, tckn: String, address: String, completion: @escaping (Result<PostModel, Error>) -> Void) {
        networkManager.updateEmployee(Id: employeeId, name: name, surname: surname, email: email, address: phone, tckn: tckn, phone: address) { result in
            completion(result)
        }
    }
}
