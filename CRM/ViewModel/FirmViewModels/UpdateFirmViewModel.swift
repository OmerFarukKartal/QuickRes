//
//  UpdateFirmViewModel.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 14.12.2023.
//

import Foundation

final class UpdateFirmViewModel {
    
    let networManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networManager = networkManager
    }
    
    func updateFirm (Id: Int, activityAreaId: Int, businessTypeId: Int, cityId: Int, name: String, mapLocation: String, address: String, district: String, postCode: String, phone: String, email: String, webSite: String, taxNumber: String, taxOffice: String, foundingDate: String, linkedin: String, instagram: String, numberOfEmployees: Int, description: String, isCustomer: Bool, isSupplier: Bool) {
        networManager.updateFirm(Id: Id, activityAreaId: activityAreaId, businessTypeId: businessTypeId, cityId: cityId, name: name, /*mapLocation: mapLocation,*/ address: address, district: district, postCode: postCode, phone: phone, email: email, webSite: webSite, taxNumber: taxNumber, taxOffice: taxOffice, foundingDate: foundingDate, linkedin: linkedin, instagram: instagram, numberOfEmployees: numberOfEmployees, description: description, isCustomer: isCustomer, isSupplier: isSupplier) { response in
            switch response {
            case .success(let success):
                if success.success == true {
                    print("Güncellendi")
                }else {
                    print("Güncellenemedi")
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
