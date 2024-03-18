import UIKit

class EmployeeDetailViewController: UIViewController {
    
    var employee: EmployeeModel?
    var deleteEmployeeViewModel = DeleteEmployeeViewModel()
    var alert : Employee?
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 64
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var fullName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var tcknLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureView()
        setupNavigationBar()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let views = [profileImage, fullName, surnameLabel, emailLabel, phoneLabel, tcknLabel, addressLabel]
        views.forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImage.widthAnchor.constraint(equalToConstant: 128),
            profileImage.heightAnchor.constraint(equalToConstant: 128),
            
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            fullName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 36),
            
            surnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            surnameLabel.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 16),
            
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            emailLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 16),
            
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            
            tcknLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            tcknLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 16),
            
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05),
            addressLabel.topAnchor.constraint(equalTo: tcknLabel.bottomAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureView() {
        guard let employee = employee else { return }
        
        fullName.text = "\(employee.name ?? "") \(employee.surname ?? "")"
        emailLabel.text = employee.email
        phoneLabel.text = employee.phone
        tcknLabel.text = employee.tckn
        addressLabel.text = employee.adress
        
        profileImage.image = UIImage(named: "placeholder")
    }
    
    private func setupNavigationBar() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        
        let customEditButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(editButtonTapped))
        
        navigationItem.rightBarButtonItems = [customEditButton, deleteButton]
    }

    @objc private func editButtonTapped() {
        let editEmployeeVC = EditEmployeeViewController()
        editEmployeeVC.employeeInfo = self.employee
        self.navigationController?.pushViewController(editEmployeeVC, animated: true)
    }


    @objc private func deleteButtonTapped() {
        let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this employee?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            // Silme işlemi burada gerçekleştirilebilir
            self?.deleteEmployee()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }

    private func deleteEmployee() {
        guard let employeeId = employee!.id else {
            return
        }

        deleteEmployeeViewModel.deleteEmployee(employeeId: employeeId) { [weak self] result in
            switch result {
            case .success:
                self?.showSuccessAlert()
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }

    private func showSuccessAlert() {
        let successAlert = UIAlertController(title: "Success", message: "Employee deleted successfully.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        successAlert.addAction(okAction)
        present(successAlert, animated: true, completion: nil)
    }

    private func showErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: "Failed to delete employee. \(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
