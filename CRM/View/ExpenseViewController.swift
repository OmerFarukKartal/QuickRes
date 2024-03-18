import UIKit
import RingPieChart


class PopupTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopupPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class PopupPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        return CGRect(x: 0, y: containerView.bounds.height / 2, width: containerView.bounds.width, height: containerView.bounds.height / 2)
    }
}

class ExpenseViewController: UIViewController, AddExpensesDelegate {
    func didAddExpense() {
        fetchExpenseList()
    }
    
    var customTransitioningDelegate: PopupTransitioningDelegate?
    var cir: Circular!
    
    var barChartView: UIView!
    var pieChartView: UIView!
    
    var expenseViewModel = ExpenseViewModel()
    var expenseList = [ExpenseModel]()
    var sharedColors: [UIColor] = []

    
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var stackViewUp: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var barChartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var pieChartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private lazy var stackViewDown: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let percentageSegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Item 1", "Item 2", "Item 3"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let animationSegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Animation 1", "Animation 2", "Animation 3"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Expense List"
        configureUI()
        fetchExpenseList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCharts()
        
    }
    
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.09),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let mainStackView = UIStackView()
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            mainStackView.axis = .vertical
            mainStackView.distribution = .fillEqually
            view.addSubview(mainStackView)

            NSLayoutConstraint.activate([
                mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.1),
                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.1),
                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width * 0.1),
                mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
        barChartView = UIView()
        pieChartView = UIView()
        
        pieChartStackView.addArrangedSubview(pieChartView)
        barChartStackView.addArrangedSubview(barChartView)
        
        stackViewUp.addArrangedSubview(pieChartStackView)
        stackViewUp.addArrangedSubview(barChartStackView)
        
        stackViewDown.addArrangedSubview(tableView)
        
        mainStackView.addArrangedSubview(stackViewUp)
        mainStackView.addArrangedSubview(stackViewDown)
        
        pieChartView.centerXAnchor.constraint(equalTo: pieChartStackView.centerXAnchor).isActive = true
        pieChartView.centerYAnchor.constraint(equalTo: pieChartStackView.centerYAnchor).isActive = true

        barChartView.centerXAnchor.constraint(equalTo: barChartStackView.centerXAnchor).isActive = true
        barChartView.centerYAnchor.constraint(equalTo: barChartStackView.centerYAnchor).isActive = true


        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
    }
    
    @objc private func addButtonTapped() {
        let addExpenseVC = AddExpensesViewController()
        addExpenseVC.delegate = self
        addExpenseVC.modalPresentationStyle = .custom
        
        let customTransitioningDelegate = PopupTransitioningDelegate()
        addExpenseVC.transitioningDelegate = customTransitioningDelegate
        
        present(addExpenseVC, animated: true, completion: nil)
    }
    
    private func fetchExpenseList() {
        expenseViewModel.getExpenseCategories { [weak self] result in
            switch result {
            case .success(let expense):
                DispatchQueue.main.async {
                    self?.expenseList = expense
                    self?.tableView.reloadData()
                    self?.updateCharts()
                }
            case .failure(let error):
                print("Expense fetch error: \(error.localizedDescription)")
            }
        }
    }

    
    private func updateCharts() {
        guard isViewLoaded, view.window != nil else {
            return
        }
        updateBarChart()
        pieChart()
    }
    
    private func updateBarChart() {
        let totalAmounts = expenseViewModel.calculateTotalAmounts()
        let maxValue = totalAmounts.values.max() ?? 0.0

        barChartView.subviews.forEach { $0.removeFromSuperview() }

        for (index, (category, amount)) in totalAmounts.enumerated() {
            let barHeight = CGFloat(amount / maxValue) * barChartStackView.frame.height * 0.8
            let barWidth: CGFloat = barChartStackView.frame.width * 0.1
            let gapWidth: CGFloat = 30

            let barView = UIView()
            let barColor = sharedColors.count > index ? sharedColors[index] : randomColor()
            barView.backgroundColor = barColor
            barView.translatesAutoresizingMaskIntoConstraints = false
            barChartView.addSubview(barView)

            let label = UILabel()
            label.text = "\(category)"
            label.font = UIFont.systemFont(ofSize: 10)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            barChartView.addSubview(label)

            let amountLabel = UILabel()
            amountLabel.text = "\(amount)"
            amountLabel.font = UIFont.systemFont(ofSize: 12)
            amountLabel.textAlignment = .center
            amountLabel.translatesAutoresizingMaskIntoConstraints = false
            barChartView.addSubview(amountLabel)

            NSLayoutConstraint.activate([
                barView.heightAnchor.constraint(equalToConstant: barHeight),
                barView.widthAnchor.constraint(equalToConstant: barWidth),
                barView.leadingAnchor.constraint(equalTo: barChartView.leadingAnchor, constant: CGFloat(index) * (barWidth + gapWidth)),
                barView.bottomAnchor.constraint(equalTo: barChartView.bottomAnchor, constant: -0.38 * barChartStackView.frame.height),

                label.topAnchor.constraint(equalTo: barView.bottomAnchor),
                label.centerXAnchor.constraint(equalTo: barView.centerXAnchor),

                amountLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
                amountLabel.centerXAnchor.constraint(equalTo: label.centerXAnchor)
            ])
        }
    }




    private func pieChart() {
        let totalAmounts = expenseViewModel.calculateTotalAmounts()
        var percentages: [Double] = []
        var colors: [UIColor] = []

        let totalAmount = totalAmounts.values.reduce(0, +)

        for (index, (_, amount)) in totalAmounts.enumerated() {
            let scaledAmount = amount / 1000.0
            let percentage = (scaledAmount / (totalAmount / 1000.0)) * 100.0
            percentages.append(percentage)

            let color = sharedColors.count > index ? sharedColors[index] : randomColor()
            colors.append(color)
        }

        if cir != nil {
            cir.removeFromSuperview()
        }

        cir = Circular(percentages: percentages, colors: colors)
        cir.animationType = AnimationStyle(rawValue: animationSegment.selectedSegmentIndex) ?? .animationFanAll
        cir.showPercentageStyle = PercentageStyle(rawValue: percentageSegment.selectedSegmentIndex) ?? .none

        let newWidth = pieChartStackView.frame.width / 1.5
        let newHeight = pieChartStackView.frame.height / 1.5
        cir.frame = CGRect(x: 0.0, y: 0.0, width: newWidth, height: newHeight)

        cir.lineWidth = 10

        stackViewUp.addSubview(cir)
    }


    private func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension ExpenseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)
        let expense = expenseList[indexPath.row]
        cell.textLabel?.text = expense.expenseCategory.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showExpenseDetailsAlert(for: indexPath.row)
    }
    
    private func showExpenseDetailsAlert(for index: Int) {
        let expense = expenseList[index]
        
        let alert = UIAlertController(title: "Harcama Detayları",
                                      message: expenseDetailsMessage(for: expense),
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func expenseDetailsMessage(for expense: ExpenseModel) -> String {
        return """
        Tarih: \(expense.receiptDate ?? "")
        Oluşturulma Tarihi: \(expense.createdDate ?? "")
        Miktar: \(expense.amount ?? 0)
        KDV Oranı: \(expense.kdvRate ?? 0)
        KDV Miktarı: \(expense.kdvAmount ?? 0.0)
        Kategori ID: \(expense.expenseCategoryID ?? 0)
        Vergi Numarası: \(expense.receiptTaxNumber ?? 0)
        Fiş Numarası: \(expense.receiptNo ?? 0)
        Onay Durumu: \(expense.isConfirmed ?? false)
        Kullanıcı Email: \(expense.user.email ?? "")
        Kategori Açıklama: \(expense.expenseCategory.description ?? "")
        """
    }
}
