import UIKit

var accessToken: String {
    return UserDefaults.standard.string(forKey: "accessToken") ?? ""
}

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case getEmployeeList
    case getFirmList
    case getCustomerFirmList
    case getSupplierFirmList
    case getEmployeeById(page: Int)
    case getFirmById(Id: Int)
    case setEmployee(name: String, surname: String, email: String, adress: String, tckn: String, phone: String, workTitle: String, imageUrl: String)
    case deleteEmployee(Id: Int)
    case getCity
    case getArea
    case getBusinessType
    case getLeadTypes
    case getStatusType
    case getCurrencyTpe
    case getPrecedence
    case getLead
    case addLead(customerName: String, currencyTypeId: Int, leadTypeId: Int, leadAmount: Double, createDate: String, resource: String, precedenceId: Int, title: String, description: String, userEmail: String, leadStatusId: Int, associatedOfferName: String?, status: Bool)
    case addFirm(activityAreaId: Int, businessTypeId: Int, cityId: Int, name: String, adress: String, district: String, postCode: String, phone: String, email: String, webSite: String, taxNumber: String, taxOffice: String, foundingDate: String, linkedin: String, instagram: String, numberOfEmployees: Int, description: String, isCustomer: Bool, isSupplier: Bool)
    case updateEmployee(Id: Int, name: String, surname: String, email: String, address: String, tckn: String, phone: String)
    case updateFirm(Id: Int, activityAreaId: Int, businessTypeId: Int, cityId: Int, name: String, adress: String, district: String, postCode: String, phone: String, email: String, webSite: String, taxNumber: String, taxOffice: String, foundingDate: String, linkedin: String, instagram: String, numberOfEmployees: Int, description: String, isCustomer: Bool, isSupplier: Bool)
    case deleteFirm(Id: Int)
    case deleteLead(Id: Int)
    case addExpense(EmployeId: Int, ReceiptDate: String, Amount: Double, KdvRate: Int, ExpenseCategoryId: Int, ReceiptTaxNumber: Int, ReceiptNo: Int, KdvAmount: Double, isConfirmed: Bool, imageUrl: String)
    case getExpense
    case getExpenseCategory
}

extension Endpoint: EndpointProtocol {

    var baseURL: String {
        return "https://ipmapi.ipmsoft.com.tr"
    }

    var path: String {
        switch self {
        case .getEmployeeList:  return "/Employe/GetList"
        case .getFirmList:  return "/Firm/GetAllFirms"
        case .getCustomerFirmList: return "/Firm/GetCustomerFirms"
        case .getSupplierFirmList: return "/Firm/GetSupplierFirms"
        case .getEmployeeById(let page):    return "/Employe/GetById/\(page)"
        case .getFirmById(let Id):  return "/Firm/GetFirmById/\(Id)"
        case .getExpense:   return "/Expense/GetList"
        case .setEmployee:  return "/Employe/Add"
        case .deleteEmployee(let Id):   return "/Employe/Delete/\(Id)"
        case .getCity:  return "/Parameter/GetCityList"
        case .getArea:  return "/Parameter/GetFirmAreaActivityList"
        case .getBusinessType:  return "/Parameter/GetBusinessTypeList"
        case .getLeadTypes: return "/Parameter/GetLeadTypes"
        case .getStatusType: return "/Parameter/GetLeadStatus"
        case .getCurrencyTpe: return "/Parameter/GetCurrencyType"
        case .getPrecedence: return "/Parameter/GetPrecedence"
        case .getExpenseCategory: return "/Parameter/GetExpenseCategory"
        case .addFirm:  return "/Firm/AddFirm"
        case .getLead:  return "/Lead/GetList"
        case .addLead: return "/Lead/Add"
        case .addExpense: return "/Expense/Add"
        case .updateEmployee:   return "/Employe/Add"
        case .deleteFirm(let Id):   return "/Firm/DeleteFirm/\(Id)"
        case .deleteLead(let Id): return "/Lead/Delete/\(Id)"
        case .updateFirm: return "/Firm/AddFirm"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getEmployeeList, .getFirmList, .getCustomerFirmList, .getSupplierFirmList, .getEmployeeById, .getFirmById, .getArea, .getLeadTypes, .getStatusType, .getBusinessType, .getCurrencyTpe, .getCity, .getExpenseCategory, .getPrecedence, .getExpense, .getLead: return .get
        case .setEmployee, .deleteEmployee, .addFirm, .updateEmployee, .deleteFirm, .deleteLead, .addLead, .updateFirm, .addExpense:  return .post
        }
    }

    var headers: [String: String]? {
        return [
            "Content-type": "application/json; charset=UTF-8",
            "Authorization": "Bearer \(accessToken)"
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .getEmployeeList, .getFirmList, .getExpense, .getExpenseCategory, .getCustomerFirmList, .getSupplierFirmList, .getEmployeeById, .getFirmById, .getCity, .getArea, .getBusinessType, .getLeadTypes, .getStatusType, .getCurrencyTpe, .getLead, .getPrecedence:
            return nil
        case .setEmployee(let name, let surname, let email, let adress, let tckn, let phone, let workTitle, let imageUrl):
            return [
                "name": name,
                "surname": surname,
                "email": email,
                "adress": adress,
                "tckn": tckn,
                "phone": phone,
                "workTitle": workTitle,
                "imageUrl": ""
            ]
        case .deleteEmployee, .deleteFirm, .deleteLead:
            return nil

        case .addFirm(let activityAreaId, let businessTypeId, let cityId, let name, let adress, let district, let postCode, let phone, let email, let webSite, let taxNumber, let taxOffice, let foundingDate, let linkedin, let instagram, let numberOfEmployees, let description, let isCustomer, let isSupplier):
            return [
                "activityAreaId": activityAreaId,
                "businessTypeId": businessTypeId,
                "cityId": cityId,
                "name": name,
                "adress": adress,
                "district": district,
                "postCode": postCode,
                "phone": phone,
                "email": email,
                "webSite": webSite,
                "taxNumber": taxNumber,
                "taxOffice": taxOffice,
                "foundingDate": foundingDate,
                "linkedin": linkedin,
                "instagram": instagram,
                "numberOfEmployees": numberOfEmployees,
                "description": description,
                "isCustomer": isCustomer,
                "isSupplier": isSupplier
            ]

                case .addLead( let customerName, let currencyTypeId, let leadTypeId, let leadAmount, let createDate, let resource, let precedenceId, let title, let description, let userEmail, let leadStatusId, let status, let associatedOfferName ):
                    return [
                        "customerName": customerName,
                        "currencyTypeId": currencyTypeId,
                        "leadTypeId": leadTypeId,
                        "leadAmount": leadAmount,
                        "createDate": createDate,
                        "resource": resource,
                        "precedenceId": precedenceId,
                        "title": title,
                        "description": description,
                        "userEmail": userEmail,
                        "leadStatusId": leadStatusId,
                        "status": false,
                        "associatedOfferName": ""
                    ]

        case .addExpense(let EmployeId, let ReceiptDate, let Amount, let KdvRate, let ExpenseCategoryId, let ReceiptTaxNumber, let ReceiptNo,let KdvAmount, let isConfirmed, let imageUrl):
            return [
                "EmployeId": EmployeId,
                "ReceiptDate": ReceiptDate,
                "Amount": Amount,
                "kdvRate": KdvRate,
                "ExpenseCategoryId": ExpenseCategoryId,
                "ReceiptTaxNumber": ReceiptTaxNumber,
                "ReceiptNo": ReceiptNo,
                "KdvAmount": KdvAmount,
                "isConfirmed": false,
                "imageUrl": "Hello"
            ]


        case .updateEmployee(let Id, let name, let surname, let email, let address, let tckn, let phone):
            return [
                "id": Id,
                "name": name,
                "surname": surname,
                "email": email,
                "adress": address,
                "tckn": tckn,
                "phone": phone,
                "imageUrl": "http://dummyimage.com/129x100.png/ff4444/ffffff",
                "workTitle": "Satış Danışmanı"
            ]

        case .updateFirm(let Id, let activityAreaId, let businessTypeId, let cityId, let name, let adress, let district, let postCode, let phone, let email, let webSite, let taxNumber, let taxOffice, let foundingDate, let linkedin, let instagram, let numberOfEmployees, let description, let isCustomer, let isSupplier):
            return [
                "id": Id,
                "activityAreaId": activityAreaId,
                "businessTypeId": businessTypeId,
                "cityId": cityId,
                "name": name,
                "adress": adress,
                "district": district,
                "postCode": postCode,
                "phone": phone,
                "email": email,
                "webSite": webSite,
                "taxNumber": taxNumber,
                "taxOffice": taxOffice,
                "foundingDate": foundingDate,
                "linkedin": linkedin,
                "instagram": instagram,
                "numberOfEmployees": numberOfEmployees,
                "description": description,
                "isCustomer": isCustomer,
                "isSupplier": isSupplier
            ]
        }
    }

    func request() -> URLRequest {
        guard let components = URLComponents(string: baseURL),
              let url = components.url?.appendingPathComponent(path) else {
            fatalError("URL Hatası")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }

        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}


   
