import UIKit

protocol AddExpensesDelegate: AnyObject {
    func didAddExpense()
}

protocol AddExpenseViewModelDelegate: AnyObject{
    func expenseAddedSuccessfully()
    func addingExpenseFailed(with error: Error)
}

class AddExpensesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var expenseTypeList: [[String]] = []
    var expenceTypeListViewModel = ParameterViewModel()
    var selectedExpenseTypeId: Int?
    var expenseTypePickerView: UIPickerView?
    
    weak var delegate: AddExpensesDelegate?

    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kaydet", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let calculateKdvAmount: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate Kdv Amount", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let receiptDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Fiş Tarihi"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var createDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy var createDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [receiptDateTextField, createDatePicker])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var kdvAmountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kdvRateTextField, calculateKdvAmount])
        stackView.axis = .horizontal
        stackView.spacing = 200
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Tutar"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let kdvRateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "KDV Oranı"
        textField.keyboardType = .numbersAndPunctuation
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let expenseCategoryIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Masraf Kategori ID"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let receiptTaxNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Fiş Vergi Numarası"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let receiptNoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Fiş Numarası"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let kdvAmountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "KDV Tutarı"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var amountValueDouble: Double? {
        return Double(amountTextField.text ?? "0")
    }
    
    var kdvRateValueDouble: Double? {
        return Double(kdvRateTextField.text ?? "0")
    }
    
   @objc func setTarget() {
        kdvAmountTextField.text = String(describing: calculateKdvAmount(amount: amountValueDouble ?? 0, kdvRate: kdvRateValueDouble ?? 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        title = "Masraflar"
        fetchExpenseType()

        let mainStackView: UIStackView = {
                let stackView = UIStackView(arrangedSubviews: [createDateStackView, expenseCategoryIdTextField, receiptTaxNumberTextField, receiptNoTextField, amountTextField, kdvAmountStackView,  kdvAmountTextField, saveButton])
                stackView.axis = .vertical
                stackView.spacing = view.frame.height * 0.018
                stackView.alignment = .fill
                stackView.distribution = .fillEqually
                stackView.translatesAutoresizingMaskIntoConstraints = false
                return stackView
            }()

            view.addSubview(mainStackView)
            expenseCategoryIdTextField.inputView = expenseTypePickerView

            NSLayoutConstraint.activate([
                mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.08),
                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1),
                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width * 0.1),
                mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.08)
            ])
        

        saveButton.addTarget(self, action: #selector(gonderButtonTapped), for: .touchUpInside)
        createDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expenseCategoryTextFieldTapped))
        expenseCategoryIdTextField.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe))
            view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        switch gesture.state {
        case .changed:
            if translation.y < 0 {
                
            }
            else {
                dismiss(animated: true, completion: nil)
            }

        default:
            break
        }
    }


    
    @objc private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func expenseCategoryTextFieldTapped() {
        showExpenseTypePicker()
    }
    
    private func showExpenseTypePicker() {
        if expenseTypePickerView == nil {
            expenseTypePickerView = UIPickerView()
            expenseTypePickerView?.delegate = self
            expenseTypePickerView?.dataSource = self
        }
        
        view.endEditing(true)
        
        expenseTypePickerView?.isHidden = false
    }
    
    
    private func fetchExpenseType() {
        expenceTypeListViewModel.getExpenseCategory { [weak self] expenseType in
            DispatchQueue.main.async {
                self?.expenseTypeList = expenseType
                self?.expenseCategoryIdTextField.inputView = self?.expenseTypePickerView
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == expenseTypePickerView {
            return expenseTypeList.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == expenseTypePickerView {
            return expenseTypeList[row].first
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == expenseTypePickerView {
            expenseCategoryIdTextField.text = expenseTypeList[row][0]
            selectedExpenseTypeId = Int(expenseTypeList[row][1])
        }
    }

    
    @objc private func selectExpenseTapped() {
        expenseCategoryIdTextField.becomeFirstResponder()
    }
    
    @objc private func expenseTextFieldEditing() {
        expenseTypePickerView?.reloadAllComponents()
    }
    
    @objc private func dismissKeyboardOrPicker() {
        view.endEditing(true)
    }
    
    @objc private func dateChanged() {
        receiptDateTextField.text = formatDate(createDatePicker.date)
    }
    
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    @objc private func gonderButtonTapped() {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int,
              let receiptDate = receiptDateTextField.text,
              let amountString = amountTextField.text,
              let amount = Double(amountString),
              let kdvRateString = kdvRateTextField.text,
              let kdvRate = Double(kdvRateString),
              let expenseCategoryId = selectedExpenseTypeId,
              let receiptTaxNumberString = receiptTaxNumberTextField.text,
              let receiptTaxNumber = Int(receiptTaxNumberString),
              let receiptNoString = receiptNoTextField.text,
              let receiptNo = Int(receiptNoString),
              let kdvAmountString = kdvAmountTextField.text,
              let kdvAmount = Double(kdvAmountString) 
        else {
            print("Tüm alanları doldur")
            return
        }
        
      
        let viewModel = AddExpenseViewModel(networkManager: NetworkManager.shared)
        viewModel.addExpense(
            EmployeId: userId,
            ReceiptDate: receiptDate,
            CreateDate: formatDate(Date()),
            Amount: amount,
            KdvRate: Int(kdvRate),
            imageUrl: "sampleImageUrl",
            ExpenceCategoryId: expenseCategoryId,
            ReceiptTaxNumber: receiptTaxNumber,
            ReceiptNo: receiptNo,
            isConfirmed: false,
            KdvAmount: kdvAmount
        ) { result in
            switch result {
            case .success(let postModel):
                print("Post başarılı: \(postModel)")
            case .failure(let error):
                print("Post hatası: \(error.localizedDescription)")
            }
        }
    }
    func expenseAddedSuccessfully() {
        print("Expense added successfully")
    }
    
    func addingExpenseFailed(with error: Error) {
        print("Error adding employee: \(error.localizedDescription)")
    }
    
    func calculateKdvAmount(amount: Double, kdvRate: Double) -> Double {
        
        guard amount > 0 else { return 0 }
        let val = (amount * kdvRate / (100 + kdvRate))
        return round(val * 100) / 100
        
    }
    
}
