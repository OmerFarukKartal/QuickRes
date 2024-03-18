import Foundation
import UIKit

class FirmListViewController: UIViewController {
    var viewModel = FirmViewModel()
    var tableView = UITableView()
    var deleteFirmViewModel = DeleteFirmViewModel()
    var tableViewData: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let titleLabel = UILabel()
        titleLabel.text = "Firms"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let segmentedControl = UISegmentedControl(items: ["Supplier", "Customer", "All"])
        segmentedControl.selectedSegmentIndex = 0 // Varsayılan olarak "Supplier" seçili
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        let initialSegmentIndex = 2
            segmentedControl.selectedSegmentIndex = initialSegmentIndex

            segmentedControlValueChanged(segmentedControl)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Hücre tanımlayıcısını kaydet
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeArea.trailingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.getFirmList { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Firma listesi alınamadı: \(error)")
            }
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.fetchSupplierFirms { result in
                switch result {
                case .success(let success):
                    let firmNames = success.map { $0.name }
                    self.tableViewData = firmNames
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                        print("Error fetching customer firms: \(error)")
                }
            }
        case 1:
            viewModel.fetchCustomerFirms { result in
                switch result {
                case .success(let customerFirms):
                    let firmNames = customerFirms.map { $0.name }

                    self.tableViewData = firmNames

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching customer firms: \(error)")
                }
            }
        case 2:
            viewModel.getFirmList { result in
                switch result {
                case .success(let success):
                    let firms = self.viewModel.firms
                    self.tableViewData = firms.map { $0.name }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("Error fetching customer firms: \(error)")

                }
            }
        default:
            break
        }
    }


    
    @objc func addButtonTapped() {
        let addFirmVc = AddFirmViewController()
        self.navigationController?.pushViewController(addFirmVc, animated: true)
    }
}

extension FirmListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFirms()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let firmName = viewModel.firmName(at: indexPath.row) {
            cell.textLabel?.text = firmName
        } else {
            cell.textLabel?.text = "Veri Yok"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.firms[indexPath.row]
        let vc = FirmDetailViewController()
        vc.firm = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            // Silme işlemini gerçekleştir
            self?.showDeleteConfirmationAlert(at: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func showDeleteConfirmationAlert(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this Firm?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteFirm(at: indexPath)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteFirm(at indexPath: IndexPath) {
        guard let firmIdToDelete = viewModel.firms[indexPath.row].id else {
            print("Silme işlemi başarısız: Firm ID'si bulunamadı.")
            return
        }
        
        deleteFirmViewModel.deleteFirm(firmId: firmIdToDelete) { [weak self] result in
            switch result {
            case .success:
                self?.viewModel.getFirmList { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("Firma listesi alınamadı: \(error)")
                    }
                }
            case .failure(let error):
                print("Silme işlemi başarısız: \(error.localizedDescription)")
            }
        }
    }
}
