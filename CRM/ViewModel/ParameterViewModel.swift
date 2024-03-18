import Foundation

class ParameterViewModel {
    
    var getLeadTypeList: [GetParametersModel] = []
    var errorMessage = ""
    
    let networkManager = NetworkManager.shared
    
    func getLeadTypes(completion: @escaping ([[String]]) -> Void) {
        networkManager.self.getLeadTypes { result in
            switch result {
            case .success(let success):
                var leadTypesData: [[String]] = []
                success.data?.forEach{ leadType in
                    if let description = leadType.description, let id = leadType.id {
                        let idString = String(id)
                        leadTypesData.append([description, idString])
                    }
                }
                completion(leadTypesData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func getLeadStatus(completion: @escaping ([[String]]) -> Void) {
        networkManager.getStatusType { result in
            switch result {
            case .success(let success):
                var leadStatusData: [[String]] = []
                success.data?.forEach{ statu in
                    if let description = statu.description, let id = statu.id {
                        let idString = String(id)
                        leadStatusData.append([description, idString])
                    }
                }
                completion(leadStatusData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func getCurrencyType(completion: @escaping ([[String]]) -> Void) {
        networkManager.getCurrencyType { result in
            switch result {
            case .success(let success):
                var currencyData: [[String]] = []
                success.data?.forEach{ currency in
                    if let description = currency.description, let id = currency.id {
                        let idString = String(id)
                        currencyData.append([description, idString])
                    }
                }
                completion(currencyData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func getPrecedence(completion: @escaping ([[String]]) -> Void) {
        networkManager.getPrecedence { result in
            switch result {
            case .success(let success):
                var precedenceData: [[String]] = []
                success.data?.forEach{ precedence in
                    if let description = precedence.description, let id = precedence.id {
                        let idString = String(id)
                        precedenceData.append([description, idString])
                    }
                }
                completion(precedenceData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func getExpenseCategory(completion: @escaping ([[String]]) -> Void) {
        networkManager.getExpenceCategory { result in
            switch result {
            case .success(let success):
                var expenceCategory: [[String]] = []
                success.data?.forEach{ expenceCategories in
                    if let description = expenceCategories.description, let id = expenceCategories.id {
                        let idString = String(id)
                        expenceCategory.append([description, idString])
                    }
                }
                completion(expenceCategory)
            case .failure(let failure):
                print(failure.localizedDescription)
                
            }
        }
    }
}

