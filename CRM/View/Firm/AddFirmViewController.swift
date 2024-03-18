import UIKit
import MapKit
class AddFirmViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cityPickerView: UIPickerView?
    var firmTypePickerView: UIPickerView?
    var firmAreaPickerView: UIPickerView?
    var selectedCity: String?
    var selectedFirmType: String?
    var selectedFirmArea: String?
    var firmCityListViewModel = FirmCityListViewModel()
    var firmCityList: [[String]] = []
    var firmAreaListViewModel = FirmAreaListViewModel()
    var firmAreaList: [[String]] = []
    var firmTypeListViewModel = FirmTypeListViewModel()
    var firmTypeList: [[String]] = []
    var selectedCityId: Int?
    var selectedFirmTypeId: Int?
    var selectedFirmAreaId: Int?
    var addFirmViewModel = AddFirmViewModel()
    
    
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.date = Date()
        return datePicker
    }()
    
    let customerToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        return toggle
    }()
    
    let supplierToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        return toggle
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = UIColor.black
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.textColor = UIColor.black
        return label
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let employeeCountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Employee Count"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    let addFirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Firm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addFirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let firmNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Firm Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Phone"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let websiteTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Website"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let taxOfficeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tax Office"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let taxNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tax Number"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var foundationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    let foundationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Foundation Date:  "
        label.textColor = UIColor.black
        return label
    }()
    
    let townTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Town"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Select City"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let firmTypeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Select Firm Type"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let firmAreaTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Select Firm Area"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let postCodeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Post Code"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let linkedInTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "LinkedIn"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let instagramTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Instagram"
        textField.borderStyle = .roundedRect
        return textField
    }()
    

    let addressTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPickerViews()
        setupNotesTextView()
        
        cityPickerView?.delegate = self
        cityPickerView?.dataSource = self
        
        firmTypePickerView?.delegate = self
        firmTypePickerView?.dataSource = self
        
        firmAreaPickerView?.delegate = self
        firmAreaPickerView?.dataSource = self
        
        cityTextField.inputView = cityPickerView
        firmTypeTextField.inputView = firmTypePickerView
        firmAreaTextField.inputView = firmAreaPickerView
        cityTextField.addTarget(self, action: #selector(cityTextFieldEditing), for: .touchDown)
        firmTypeTextField.addTarget(self, action: #selector(firmTypeTextFieldEditing), for: .touchDown)
        firmAreaTextField.addTarget(self, action: #selector(firmAreaTextFieldEditing), for: .touchDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOrPicker))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        let employeeCountTapGesture = UITapGestureRecognizer(target: self, action: #selector(employeeCountTextFieldTapped))
        employeeCountTextField.isUserInteractionEnabled = true
        employeeCountTextField.addGestureRecognizer(employeeCountTapGesture)
        setupToggles()
        fetchCityList()
        fetchAreaList()
        fetchTypeList()
        
    }
    private func setupUI() {
        view.backgroundColor = .white
        title = "Add Firm"
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(firmNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(websiteTextField)
        stackView.addArrangedSubview(taxOfficeTextField)
        stackView.addArrangedSubview(taxNumberTextField)
        foundationStackView.addArrangedSubview(foundationDateLabel)
        foundationStackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(foundationStackView)
        stackView.addArrangedSubview(cityTextField)
        stackView.addArrangedSubview(townTextField)
        stackView.addArrangedSubview(firmTypeTextField)
        stackView.addArrangedSubview(employeeCountTextField)
        stackView.addArrangedSubview(postCodeTextField)
        stackView.addArrangedSubview(linkedInTextField)
        stackView.addArrangedSubview(instagramTextField)
        setupAddressTextView()
        setupNotesTextView()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.1),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
        ])
    }
    func fetchCityList() {
        self.firmCityListViewModel.getCityList { [weak self] cityData in
            DispatchQueue.main.async {
                self?.firmCityList = cityData
                self?.cityPickerView?.reloadAllComponents()
            }
        }
    }
    func fetchAreaList() {
        self.firmAreaListViewModel.getAreaList { [weak self] areaData in
            DispatchQueue.main.async {
                self?.firmAreaList = areaData
                self?.firmAreaPickerView?.reloadAllComponents()
            }
        }
    }
    func fetchTypeList() {
        self.firmTypeListViewModel.getTypeList { [weak self] typeData in
            DispatchQueue.main.async {
                self?.firmTypeList = typeData
                self?.firmTypePickerView?.reloadAllComponents()
            }
        }
    }
    func setupToggles() {
        let toggleStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 25
            return stackView
        }()
        let customerLabel: UILabel = {
            let label = UILabel()
            label.text = "Customer"
            return label
        }()
        toggleStackView.addArrangedSubview(customerLabel)
        toggleStackView.addArrangedSubview(customerToggle)
        let supplierLabel: UILabel = {
            let label = UILabel()
            label.text = "Supplier"
            return label
        }()
        toggleStackView.addArrangedSubview(supplierLabel)
        toggleStackView.addArrangedSubview(supplierToggle)
        stackView.addArrangedSubview(firmNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(websiteTextField)
        stackView.addArrangedSubview(taxOfficeTextField)
        stackView.addArrangedSubview(taxNumberTextField)
        stackView.addArrangedSubview(foundationStackView)
        stackView.addArrangedSubview(cityTextField)
        stackView.addArrangedSubview(townTextField)
        stackView.addArrangedSubview(toggleStackView)
        stackView.addArrangedSubview(firmTypeTextField)
        stackView.addArrangedSubview(firmAreaTextField)
        stackView.addArrangedSubview(employeeCountTextField)
        stackView.addArrangedSubview(postCodeTextField)
        stackView.addArrangedSubview(linkedInTextField)
        stackView.addArrangedSubview(instagramTextField)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(descriptionStackView)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(addressTextView)
        stackView.addArrangedSubview(addFirmButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.1),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
        ])
    }
    private func setupPickerViews() {
        cityPickerView = UIPickerView()
        firmTypePickerView = UIPickerView()
        firmAreaPickerView = UIPickerView()
    }
    private func setupAddressTextView() {
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(addressTextView)
        addressTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        addressTextView.delegate = self
    }
    private func setupNotesTextView() {
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionTextView.delegate = self
    }
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        print("Selected Date: \(selectedDate)")
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView == descriptionTextView {
            descriptionLabel.isHidden = !textView.text.isEmpty
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPickerView {
            return firmCityList.count
        } else if pickerView == firmTypePickerView {
            return firmTypeList.count
        } else if pickerView == firmAreaPickerView {
            return firmAreaList.count
        } else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPickerView {
            return firmCityList[row].first
        } else if pickerView == firmTypePickerView {
            return firmTypeList[row].first
        } else if pickerView == firmAreaPickerView {
            return firmAreaList[row].first
        } else {
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPickerView {
            cityTextField.text = firmCityList[row][0]
            selectedCityId = Int(firmCityList[row][1])
            cityTextField.resignFirstResponder()
        } else if pickerView == firmTypePickerView {
            firmTypeTextField.text = firmTypeList[row][0]
            selectedFirmTypeId = Int(firmTypeList[row][1])
            firmTypeTextField.resignFirstResponder()
        } else if pickerView == firmAreaPickerView {
            if firmAreaList.indices.contains(row) {
                firmAreaTextField.text = firmAreaList[row][0]
                selectedFirmAreaId = Int(firmAreaList[row][1])
                firmAreaTextField.resignFirstResponder()
            }
        }
    }
    @objc private func selectCityLabelTapped() {
        cityTextField.becomeFirstResponder()
    }
    @objc private func selectFirmTypeLabelTapped() {
        firmTypeTextField.becomeFirstResponder()
    }
    @objc private func selectFirmAreaLabelTapped() {
        firmAreaTextField.becomeFirstResponder()
    }
    @objc private func cityTextFieldEditing() {
        cityPickerView?.reloadAllComponents()
    }
    @objc private func firmTypeTextFieldEditing() {
        firmTypePickerView?.reloadAllComponents()
    }
    @objc private func firmAreaTextFieldEditing() {
        firmAreaPickerView?.reloadAllComponents()
    }
    @objc private func dismissKeyboardOrPicker() {
        view.endEditing(true)
    }
    @objc private func employeeCountTextFieldTapped() {
        employeeCountTextField.becomeFirstResponder()
    }
    @objc private func addFirmButtonTapped() {
        let foundingDate = datePicker.date
        guard let activityAreaId = selectedFirmAreaId,
              let businessTypeId = selectedFirmTypeId,
              let cityId = selectedCityId,
              let address = addressTextView.text,
              let firmName = firmNameTextField.text,
              let district = townTextField.text,
              let postCode = postCodeTextField.text,
              let phone = phoneTextField.text,
              let email = emailTextField.text,
              let webSite = websiteTextField.text,
              let taxNumber = taxNumberTextField.text,
              let taxOffice = taxOfficeTextField.text,
              let linkedin = linkedInTextField.text,
              let instagram = instagramTextField.text,
              let numberOfEmployeesText = employeeCountTextField.text,
              let numberOfEmployees = Int(numberOfEmployeesText),
              let description = descriptionTextView.text,
              let isCustomer = customerToggle.isOn as Bool?,
              let isSupplier = supplierToggle.isOn as Bool? else {
            displayErrorAlert(message: "Lütfen tüm alanları doldurun.")
            return
        }
        
        addFirmViewModel.addFirm(
            activityAreaId: activityAreaId,
            businessTypeId: businessTypeId,
            cityId: cityId,
            name: firmName,
            address: address,
            district: district,
            postCode: postCode,
            phone: phone,
            email: email,
            webSite: webSite,
            taxNumber: taxNumber,
            taxOffice: taxOffice,
            foundingDate: dateFormatter.string(from: foundingDate),
            linkedin: linkedin,
            instagram: instagram,
            numberOfEmployees: numberOfEmployees,
            description: description,
            isCustomer: isCustomer,
            isSupplier: isSupplier
        ) { result in
            switch result {
            case .success(let response):
                print("Firma başarıyla eklendi. Yanıt: \(response)")
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.displayErrorAlert(message: "Firma eklenirken hata oluştu. \(error.localizedDescription)")
            }
        }
    }
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
