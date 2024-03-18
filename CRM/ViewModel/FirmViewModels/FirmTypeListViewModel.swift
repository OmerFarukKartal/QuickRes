import Foundation

class FirmTypeListViewModel {
    
    var firmTypeList: [GetParametersModel] = []
    var errorMessage = ""
    
    func getTypeList(completion: @escaping ([[String]]) -> Void) {
        NetworkManager.shared.getType { result in
            switch result {
            case .success(let success):
                var typeData: [[String]] = []
                success.data?.forEach { type in
                    if let description = type.description, let id = type.id {
                        // ID'yi String'den Integer'a çevir
                        let idString = String(id)
                        typeData.append([description, idString])
                    }
                }
                completion(typeData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
