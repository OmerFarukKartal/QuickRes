import UIKit

class FirmDetailViewController: UIViewController {
    
    var firm: Firm?
    var deleteFirmViewModel = DeleteFirmViewModel()
    var alert: FirmDeleteResponse?
    
    let firmaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        updateUI()
        setupNavigationBar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setupUI() {
        view.addSubview(firmaImageView)
        view.addSubview(nameLabel)
        view.addSubview(addressLabel)
        view.addSubview(phoneLabel)
        view.addSubview(websiteLabel)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            firmaImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firmaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firmaImageView.heightAnchor.constraint(equalToConstant: 100),
            firmaImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: firmaImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            phoneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            websiteLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func updateUI() {
        guard let firm = firm else { return }
        nameLabel.text = "Name: \(firm.name)"
        addressLabel.text = "Address: \(firm.adress )"
        phoneLabel.text = "Phone: \(firm.phone)"
        websiteLabel.text = "Website: \(firm.webSite )"
        emailLabel.text = "Email: \(firm.email )"
    }
    
    func setupNavigationBar() {
        let editButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(editButtonTapped))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        
        navigationItem.rightBarButtonItems = [editButton, deleteButton]
    }
    
    @objc func editButtonTapped() {
        let editFirmVC = EditFirmViewController()
        editFirmVC.firmInfo = self.firm
        self.navigationController?.pushViewController(editFirmVC, animated: true)
    }
    
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this Firm?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteFirm()
        }
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteFirm() {
        guard let firmId = firm?.id else {
            return
        }
        
        deleteFirmViewModel.deleteFirm(firmId: firmId) { [weak self] result in
            switch result {
            case .success:
                self?.showSuccessAlert()
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func showSuccessAlert() {
        let successAlert = UIAlertController(title: "Success", message: "Firm deleted successfully.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        successAlert.addAction(okAction)
        present(successAlert, animated: true, completion: nil)
    }
    
    private func showErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: "Failed to delete firm. \(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
