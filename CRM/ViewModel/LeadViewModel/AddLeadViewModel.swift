//
//  AddLeadViewModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 25.12.2023.
//

import Foundation

class AddLeadViewModel{
    
    let networkManager: NetworkManager
    weak var delegate: AddLeadViewModelDelegate?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func addLead( customerName: String, currencyTypeId: Int, leadTypeId: Int, leadAmount: Double, createDate: String, resource: String, precedenceId: Int, title: String, description: String, userEmail: String, leadStatusId: Int, status: Bool,associatedOfferName: String, completion: @escaping(Result<PostModel, Error>) -> Void){
        networkManager.addLead( customerName: customerName, currencyTypeId: currencyTypeId, leadTypeId: leadTypeId, leadAmount: leadAmount, createDate: createDate, resource: resource, precedenceId: precedenceId, title: title, description: description, userEmail: userEmail, leadStatusId: leadStatusId, status: status, associatedOfferName: associatedOfferName) { result in
            completion(result)
        }
    }
}
