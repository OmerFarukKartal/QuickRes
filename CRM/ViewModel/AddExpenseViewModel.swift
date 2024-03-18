


import Foundation

class AddExpenseViewModel {
    
    
    let networkManager: NetworkManager
    weak var delegate: AddExpensesDelegate?
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func addExpense( EmployeId: Int, ReceiptDate: String, CreateDate: String, Amount: Double, KdvRate: Int, imageUrl: String, ExpenceCategoryId: Int, ReceiptTaxNumber: Int, ReceiptNo: Int, isConfirmed: Bool, KdvAmount: Double, completion: @escaping(Result<PostModel, Error>) -> Void){
        networkManager.addExpense(EmployeId: EmployeId, ReceiptDate: ReceiptDate, CreateDate: CreateDate, Amount: Amount, KdvRate: KdvRate, imageUrl: imageUrl, ExpenseCategoryId: ExpenceCategoryId, ReceiptTaxNumber: ReceiptTaxNumber, ReceiptNo: ReceiptNo, KdvAmount: KdvAmount, isConfirmed: isConfirmed) { result in
            completion(result)
        }
    }    
}
