import Foundation

class FirmCityListViewModel {
    var firmCityList: [GetParametersModel] = []
    var errorMessage = ""
    
    func getCityList(completion: @escaping ([[String]]) -> Void) {
        NetworkManager.shared.getCity { result in
            switch result {
            case .success(let success):
                var cityData: [[String]] = []
                success.data?.forEach { city in
                    if let description = city.description, let id = city.id {
                        // ID'yi String'den Integer'a çevir
                        let idString = String(id)
                        cityData.append([description, idString])
                    }
                }
                completion(cityData)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
