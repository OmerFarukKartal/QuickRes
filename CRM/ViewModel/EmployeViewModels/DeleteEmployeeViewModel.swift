import Foundation

class DeleteEmployeeViewModel {
    let networkManager = NetworkManager.shared
    
    func deleteEmployee(employeeId: Int, completion: @escaping (Result<Employee, Error>) -> Void) {
        networkManager.deleteEmployee(Id: employeeId) { result in
            switch result {
            case .success(let deletedEmployee):
                completion(.success(deletedEmployee))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
