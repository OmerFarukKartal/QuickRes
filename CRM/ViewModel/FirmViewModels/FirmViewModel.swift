import Foundation

class FirmViewModel {
    var firms: [Firm] = []
    var customerFirms: [Firm] = []


    func getFirmList(completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkManager.shared.getFirmList { result in
            switch result {
            case .success(let success):
                self.firms = success.data
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchCustomerFirms(completion: @escaping (Result<[Firm], Error>) -> Void) {
        NetworkManager.shared.getCustomerFirmList { result in
            switch result {
            case .success(let firmResponse):
                let customerFirms = firmResponse.data
                self.firms = customerFirms
                completion(.success(customerFirms))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchSupplierFirms(completion: @escaping(Result<[Firm], Error>) -> Void) {
        NetworkManager.shared.getsupplierFirmList { result in
            switch result {
            case .success(let firmResponse):
                let supplierFirms = firmResponse.data
                self.firms = supplierFirms
                completion(.success(supplierFirms))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func numberOfFirms() -> Int {
        return firms.count
    }

    func firmName(at index: Int) -> String? {
        guard index >= 0, index < firms.count else {
            return nil
        }
        return firms[index].name
    }
}
