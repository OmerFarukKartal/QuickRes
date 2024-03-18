import Foundation

class AddFirmViewModel {
    
    let networkManager = NetworkManager.shared
    
    
    func addFirm(activityAreaId: Int, businessTypeId: Int, cityId: Int, name: String, /*mapLocation: String,*/ address: String, district: String, postCode: String, phone: String, email: String, webSite: String, taxNumber: String, taxOffice: String, foundingDate: String, linkedin: String, instagram: String, numberOfEmployees: Int, description: String, isCustomer: Bool, isSupplier: Bool, completion: @escaping (Result<PostModel, Error>) -> Void) {
        networkManager.addFirm(activityAreaId: activityAreaId, businessTypeId: businessTypeId, cityId: cityId, name: name, address: address, district: district, postCode: postCode, phone: phone, email: email, webSite: webSite, taxNumber: taxNumber, taxOffice: taxOffice, foundingDate: foundingDate, linkedin: linkedin, instagram: instagram, numberOfEmployees: numberOfEmployees, description: description, isCustomer: isCustomer, isSupplier: isSupplier) { result in
            completion(result)
        }
    }

}
