//
//  EstimateListViewController.swift
//  CRM
//
//  Created by Ömer Faruk KARTAL on 14.12.2023.
//

import Foundation
import UIKit

class LeadListViewController: UIViewController, AddLeadDelegate {
    
    var leadViewModel = LeadViewModel()
    var leadList: [String?] = []
    var deleteLeadViewModel = DeleteLeadViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Lead List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        didAddLead()
        
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
        fetchLeadList()
    }
    
    func didAddLead() {
        tableView.reloadData()
        fetchLeadList()
    }
    
    @objc func addButtonTapped() {
        DispatchQueue.main.async {
            let addLeadVC = AddLeadViewController()
            addLeadVC.delegate = self
            self.navigationController?.pushViewController(addLeadVC, animated: true)
        }
    }
    
    func fetchLeadList() {
        leadViewModel.getLeadList { [weak self] customerFirm in
            DispatchQueue.main.async {
                self?.leadList = customerFirm
                self?.tableView.reloadData()
            }
        }
    }
}

extension LeadListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeadCell") ?? UITableViewCell(style: .default, reuseIdentifier: "LeadCell")
        if let customerFİrmName = leadList[indexPath.row] {
            cell.textLabel?.text = customerFİrmName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model = self.leadViewModel.leads[indexPath.row]
        let vc = LeadDetailViewController()
        vc.lead = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            self?.deleteLead(at: indexPath)
            completion(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func deleteLead(at indexPath: IndexPath) {
        guard let leadIdDelete = leadViewModel.leads[indexPath.row].id else {
            print("Silme işlemi başarısız: Lead ID'si bulunamadı.")
            return
        }
        
        deleteLeadViewModel.deleteLead(leadId: leadIdDelete) { [weak self] result in
            switch result {
            case .success:
                self?.fetchLeadList()
            case .failure(let error):
                print("Silme işlemi başarısız: \(error.localizedDescription)")

            }
        }
    }
}

