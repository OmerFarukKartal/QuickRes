import Foundation

class AddEmployeeViewModel {

    let networkManager: NetworkManager
    weak var delegate: AddEmployeeViewModelDelegate?


    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func setEmployee(name: String, surname: String, email: String, adress: String, tckn: String, phone: String, workTitle: String, imageUrl: String, completion: @escaping (Result<PostModel, Error>) -> Void) {
        networkManager.setEmployee(name: name, surname: surname, email: email, adress: adress, tckn: tckn, phone: phone, workTitle: workTitle, imagerUrl: imageUrl) { result in
            completion(result)
        }
    }
}
