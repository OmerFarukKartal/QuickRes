import UIKit


class EmployeeViewModel{
    var employees: [EmployeeModel] = []
    
    
    var errorMessage = ""
    
    
    func getEmployeeList(completion: @escaping ([String]) -> Void) {
        NetworkManager.shared.getEmployeeList { result in
            switch result {
            case .success(let success):
                var names: [String] = []
                success.data?.forEach { employee in
                    if let name = employee.name, let surname = employee.surname {
                        let fullName = "\(name) \(surname)"
                        names.append(fullName)
                    }
                }
                if let data = success.data {
                    self.employees = data
                }
                completion(names)
            case .failure(let hata):
                print(hata.localizedDescription)
                completion([])
            }
        }
    }
}
