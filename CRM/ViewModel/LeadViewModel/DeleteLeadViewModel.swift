//
//  DeleteLeadViewModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 22.12.2023.
//

import Foundation

class DeleteLeadViewModel {
    
    let networkMaganer = NetworkManager.shared
    
    func deleteLead(leadId: Int, completion: @escaping (Result<LeadResponse, Error>) -> Void) {
        networkMaganer.deleteLead(Id: leadId) { result in
            switch result {
            case .success(let deleteLead):
                completion(.success(deleteLead))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
