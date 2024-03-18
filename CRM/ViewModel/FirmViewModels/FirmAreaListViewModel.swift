import Foundation

class FirmAreaListViewModel {
    
    var firmAreaList: [GetParametersModel] = []
    var errorMessage = ""
    
    func getAreaList(completion: @escaping ([[String]]) -> Void) {
        NetworkManager.shared.getArea { result in
            switch result {
            case .success(let success):
                var areaData: [[String]] = []
                success.data?.forEach { area in
                    if let description = area.description, let id = area.id {
                        let idString = String(id)
                        areaData.append([description, idString])
                    }
                }
                completion(areaData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
