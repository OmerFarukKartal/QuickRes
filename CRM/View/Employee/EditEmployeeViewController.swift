import UIKit

class EditEmployeeViewController: UIViewController {

    var employeeInfo: EmployeeModel?
    var viewModel = UpdateEmployeeViewModel(networkManager: .shared)

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tcknTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Tckn"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Address"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    


    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "User Information"
        setupUI()
        configureTextFields()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
    // EditEmployeeViewController.swift

    private func configureTextFields() {
        guard let employee = employeeInfo else { return }

        nameTextField.text = "\(employee.name ?? "")"
        surnameTextField.text = "\(employee.surname ?? "")"
        emailTextField.text = "\(employee.email ?? "")"
        phoneTextField.text = "\(employee.phone ?? "")"
        tcknTextField.text = "\(employee.tckn ?? "")"
        addressTextField.text = "\(employee.adress ?? "")"
    }


    private func setupUI() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(tcknTextField)
        stackView.addArrangedSubview(addressTextField)
        stackView.addArrangedSubview(saveButton)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped() {
        guard let employee = employeeInfo else { return }

        // Güncellenecek bilgileri al
        guard let name = nameTextField.text,
              let id = employee.id,
              let surname = surnameTextField.text,
              let email = emailTextField.text,
              let phone = phoneTextField.text,
              let tckn = tcknTextField.text,
              let address = addressTextField.text else {
            print("Eksik bilgi var")
            return
        }
        
        viewModel.updateEmplyee(Id: id, name: name, surname: surname, email: email, address: address, tckn: tckn, phone: phone)
        
//        let employeeUpdatedVC = EmployeeListViewController()
//        self.navigationController?.pushViewController(employeeUpdatedVC, animated: true)
    }

}
