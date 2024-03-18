import Foundation

class ExpenseViewModel {
    
    var expenseCategories: [ExpenseModel] = []
    var errorMessage = ""
    
    func getExpenseCategories(completion: @escaping(Result<[ExpenseModel], Error>) -> Void) {
        NetworkManager.shared.getExpenseList { (result: Result<Expense, Error>) in
            switch result {
            case .success(let success):
                if let data = success.data {
                    self.expenseCategories = data
                    completion(.success(self.expenseCategories))
                } else {
                    let error = NSError(domain: "No data available", code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }
    func calculateTotalAmounts() -> [String: Double] {
        var totalAmounts: [String: Double] = [:]
        
        for category in expenseCategories {
            let categoryName = category.expenseCategory.description ?? "Unknown"
            let categoryAmount = Double(category.amount ?? Int(0.0))
            
            if let existingTotal = totalAmounts[categoryName] {
                totalAmounts[categoryName] = existingTotal + categoryAmount
            } else {
                totalAmounts[categoryName] = categoryAmount
            }
        }
        return totalAmounts
    }
}
