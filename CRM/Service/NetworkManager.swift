import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Invalid Response. Status Code: \(httpResponse.statusCode)")
                    } else {
                        print("Invalid Response")
                    }
                    completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "Invalid Data", code: 0)))
                    print("Invalid Data")
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("JSON decoding error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func getEmployeeList(completion: @escaping(Result<EmployeeListModel, Error>) -> Void) {
        let endpoint = Endpoint.getEmployeeList
        request(endpoint, completion: completion)
    }
    
    func getFirmList(completion: @escaping(Result<FirmResponse, Error>) -> Void) {
        let endpoint = Endpoint.getFirmList
        request(endpoint, completion: completion)
    }
    func getCustomerFirmList(completion: @escaping(Result<FirmResponse, Error>) -> Void) {
        let endpoint = Endpoint.getCustomerFirmList
        request(endpoint, completion: completion)
    }
    func getsupplierFirmList(completion: @escaping(Result<FirmResponse, Error>) -> Void) {
        let endpoint = Endpoint.getSupplierFirmList
        request(endpoint, completion: completion)
    }
    func getEmployeeById(completion: @escaping(Result<Employee, Error>) -> Void) {
        let endpoint = Endpoint.getEmployeeById(page: 8)
        request(endpoint, completion: completion)
    }
    func getFirmById(completion: @escaping(Result<FirmResponse, Error>) -> Void) {
        let endpoint = Endpoint.getFirmById(Id: 6)
        request(endpoint, completion: completion)
    }
    func setEmployee( name: String, surname: String, email: String, adress: String, tckn: String, phone: String, workTitle: String, imagerUrl: String, completion: @escaping(Result<PostModel, Error>) -> Void) {
        let endpoint = Endpoint.setEmployee(name: name, surname: surname, email: email, adress: adress, tckn: tckn, phone: phone, workTitle: workTitle, imageUrl: imagerUrl)
        request(endpoint, completion: completion)
    }
    func deleteEmployee(Id: Int, completion: @escaping(Result<Employee, Error>) -> Void){
        let endpoint = Endpoint.deleteEmployee(Id: Id)
        request(endpoint, completion: completion)
    }
    func deleteFirm(Id: Int, completion: @escaping(Result<PostModel, Error>) -> Void){
        let endpoint = Endpoint.deleteFirm(Id: Id)
        request(endpoint, completion: completion)
    }
    func  getCity(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getCity
        request(endpoint, completion: completion)
    }
    func  getArea(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getArea
        request(endpoint, completion: completion)
    }
    func  getType(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getBusinessType
        request(endpoint, completion: completion)
    }
    func addFirm(activityAreaId: Int, businessTypeId: Int, cityId: Int, name: String, /*mapLocation: String,*/ address: String, district: String, postCode: String, phone: String, email: String, webSite: String, taxNumber: String, taxOffice: String, foundingDate: String, linkedin: String, instagram: String, numberOfEmployees: Int, description: String, isCustomer: Bool, isSupplier: Bool, completion: @escaping (Result<PostModel, Error>) -> Void) {
        let endpoint = Endpoint.addFirm(activityAreaId: activityAreaId, businessTypeId: businessTypeId, cityId: cityId, name: name, /*mapLocation: mapLocation,*/ adress: address, district: district, postCode: postCode, phone: phone, email: email, webSite: webSite, taxNumber: taxNumber, taxOffice: taxOffice, foundingDate: foundingDate, linkedin: linkedin, instagram: instagram, numberOfEmployees: numberOfEmployees, description: description, isCustomer: isCustomer, isSupplier: isSupplier)
        request(endpoint, completion: completion)
    }
    func updateEmployee(Id: Int, name: String, surname: String, email: String, address: String, tckn: String, phone: String, completion: @escaping(Result<PostModel, Error>) -> Void) {
        let endpoint = Endpoint.updateEmployee(Id: Id, name: name, surname: surname, email: email, address: address, tckn: tckn, phone: phone)
        request(endpoint, completion: completion)
    }
    func updateFirm(Id: Int, activityAreaId: Int, businessTypeId: Int, cityId: Int, name: String, /*mapLocation: String,*/ address: String, district: String, postCode: String, phone: String, email: String, webSite: String, taxNumber: String, taxOffice: String, foundingDate: String, linkedin: String, instagram: String, numberOfEmployees: Int, description: String, isCustomer: Bool, isSupplier: Bool, completion: @escaping (Result<PostModel, Error>) -> Void) {
        let endpoint = Endpoint.updateFirm(Id: Id, activityAreaId: activityAreaId, businessTypeId: businessTypeId, cityId: cityId, name: name, /*mapLocation: mapLocation,*/ adress: address, district: district, postCode: postCode, phone: phone, email: email, webSite: webSite, taxNumber: taxNumber, taxOffice: taxOffice, foundingDate: foundingDate, linkedin: linkedin, instagram: instagram, numberOfEmployees: numberOfEmployees, description: description, isCustomer: isCustomer, isSupplier: isSupplier)
        request(endpoint, completion: completion)
    }
    func getLeadTypes(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getLeadTypes
        request(endpoint, completion: completion)
    }
    func getStatusType(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getStatusType
        request(endpoint, completion: completion)
    }
    func getCurrencyType(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getCurrencyTpe
        request(endpoint, completion: completion)
    }
    func getPrecedence(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getPrecedence
        request(endpoint, completion: completion)
    }
    func getLead(completion: @escaping(Result<LeadResponse, Error>) -> Void) {
        let endpoint = Endpoint.getLead
        request(endpoint, completion: completion)
    }
    func deleteLead(Id: Int, completion: @escaping(Result<LeadResponse, Error>) -> Void){
        let endpoint = Endpoint.deleteLead(Id: Id)
        request(endpoint, completion: completion)
    }
    func addLead( customerName: String, currencyTypeId: Int, leadTypeId: Int, leadAmount: Double, createDate: String, resource: String, precedenceId: Int, title: String, description: String, userEmail: String, leadStatusId: Int, status: Bool,associatedOfferName: String, completion: @escaping(Result<PostModel, Error>) -> Void) {
        let endpoint = Endpoint.addLead( customerName: customerName, currencyTypeId: currencyTypeId, leadTypeId: leadTypeId, leadAmount: leadAmount, createDate: createDate, resource: resource, precedenceId: precedenceId, title: title, description: description, userEmail: userEmail, leadStatusId: leadStatusId, associatedOfferName: associatedOfferName, status: status)
        request(endpoint, completion: completion)
    }
    func getExpenseList(completion: @escaping(Result<Expense, Error>) -> Void) {
        let endpoint = Endpoint.getExpense
        request(endpoint, completion: completion)
    }
    func addExpense(EmployeId: Int, ReceiptDate: String, CreateDate: String, Amount: Double, KdvRate: Int, imageUrl: String, ExpenseCategoryId: Int, ReceiptTaxNumber: Int, ReceiptNo: Int, KdvAmount: Double, isConfirmed: Bool, completion: @escaping(Result<PostModel, Error>) -> Void) {
        let endpoint = Endpoint.addExpense(EmployeId: EmployeId, ReceiptDate: ReceiptDate, Amount: Amount, KdvRate: KdvRate, ExpenseCategoryId: ExpenseCategoryId, ReceiptTaxNumber: ReceiptTaxNumber, ReceiptNo: ReceiptNo, KdvAmount: KdvAmount, isConfirmed: isConfirmed, imageUrl: imageUrl)
        request(endpoint, completion: completion)
    }
    func getExpenceCategory(completion: @escaping(Result<GetParametersModel, Error>) -> Void) {
        let endpoint = Endpoint.getEmployeeList
        request(endpoint, completion: completion)
    }
}
