class LeadViewModel {
    var leads: [Lead] = []
    var errorMessage = ""
    
    func getLeadList(completion: @escaping ([String]) -> Void) {
        NetworkManager.shared.getLead { result in
            switch result {
            case .success(let success):
                var customerFirm: [String] = []
                if let data = success.data {
                    for lead in data {
                        if let customerName = lead.customerName {
                            customerFirm.append(customerName)
                        }
                    }
                    self.leads = data
                } else {
                    self.errorMessage = "No data available."
                }
                completion(customerFirm)
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                print(self.errorMessage)
            }
        }
    }
}
