import UIKit

class EmployeeListViewController: UIViewController, AddEmployeeDelegate {

    var employeeViewModel = EmployeeViewModel()
    var employeeList: [String?] = []
    let deleteEmployeeViewModel = DeleteEmployeeViewModel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Employee List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        didAddEmployee()

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEmployeeList()
    }

    func didAddEmployee() {
        tableView.reloadData()
        fetchEmployeeList()
    }

    @objc func addButtonTapped() {
        DispatchQueue.main.async {
            let addEmployeVC = AddEmployeeViewController()
            addEmployeVC.delegate = self // Delegate'ı ayarlayın
            self.navigationController?.pushViewController(addEmployeVC, animated: true)
        }
    }

    func fetchEmployeeList() {
        employeeViewModel.getEmployeeList { [weak self] names in
            DispatchQueue.main.async {
                self?.employeeList = names
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource Methods
// MARK: - UITableViewDelegate Methods

extension EmployeeListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") ?? UITableViewCell(style: .default, reuseIdentifier: "EmployeeCell")
        if let name = employeeList[indexPath.row] {
            cell.textLabel?.text = name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.employeeViewModel.employees[indexPath.row]
        let vc = EmployeeDetailViewController()
        vc.employee = model
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            // Silme işlemini gerçekleştir
            self?.deleteEmployee(at: indexPath)
            completion(true)
        }

        deleteAction.backgroundColor = .red

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }

    func deleteEmployee(at indexPath: IndexPath) {
        guard let employeeIdToDelete = employeeViewModel.employees[indexPath.row].id else {
            // Optional değeri çözülemedi
            print("Silme işlemi başarısız: Çalışan ID'si bulunamadı.")
            return
        }

        deleteEmployeeViewModel.deleteEmployee(employeeId: employeeIdToDelete) { [weak self] result in
            switch result {
            case .success:
                self?.fetchEmployeeList()
            case .failure(let error):
                print("Silme işlemi başarısız: \(error.localizedDescription)")
            }
        }
    }

}
