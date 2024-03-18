import UIKit

protocol AddEmployeeDelegate: AnyObject {
    func didAddEmployee()
}

protocol AddEmployeeViewModelDelegate: AnyObject {
    func employeeAddedSuccessfully()
    func addingEmployeeFailed(with error: Error)
}

class AddEmployeeViewController: UIViewController, AddEmployeeViewModelDelegate {
    
    private let networkManager = NetworkManager.shared
    private var addEmployeeViewModel: AddEmployeeViewModel!
    weak var delegate: AddEmployeeDelegate?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter surname"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter address"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tcknLabel: UILabel = {
        let label = UILabel()
        label.text = "Tckn:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tcknTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Tckn"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter phone"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Employee", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Add Employee"
        
        addEmployeeViewModel = AddEmployeeViewModel(networkManager: NetworkManager.shared)
        addEmployeeViewModel.delegate = self
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(addressLabel)
        view.addSubview(addressTextField)
        view.addSubview(tcknLabel)
        view.addSubview(tcknTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            surnameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            surnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            addressTextField.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            addressTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tcknLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 16),
            tcknLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tcknTextField.topAnchor.constraint(equalTo: tcknLabel.bottomAnchor, constant: 8),
            tcknTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tcknTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneLabel.topAnchor.constraint(equalTo: tcknTextField.bottomAnchor, constant: 16),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func addButtonTapped() {
        let workTitle = "Satış Danışmanı"
        let imageUrl = ""

        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let tckn = tcknTextField.text, !tckn.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty
        else {
            let alertController = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        addEmployeeViewModel.setEmployee( name: name, surname: surname, email: email, adress: address, tckn: tckn, phone: phone, workTitle: workTitle, imageUrl: imageUrl ) { result in
            switch result {
            case .success(let set):
                print(set.self)
                self.delegate?.didAddEmployee()
                self.navigationController?.popViewController(animated: true)
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    func employeeAddedSuccessfully() {
        print("Employee added successfully")
    }
    
    func addingEmployeeFailed(with error: Error) {
        print("Error adding employee: \(error.localizedDescription)")
    }
}
