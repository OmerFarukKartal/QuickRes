//
//  DeleteFİrmViewModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 7.12.2023.
//

import Foundation

class DeleteFirmViewModel {
    let networkManager = NetworkManager.shared
    
    func deleteFirm(firmId: Int, completion: @escaping (Result<PostModel, Error>) -> Void) {
        networkManager.deleteFirm(Id: firmId) { result in
            switch result {
            case .success(let deleteFirm):
                completion(.success(deleteFirm))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
