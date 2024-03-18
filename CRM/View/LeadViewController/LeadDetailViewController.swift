import UIKit

class LeadDetailViewController: UIViewController {

    var lead: Lead?
    var deleteLeadViewModel = DeleteLeadViewModel()
    var alert: LeadResponse?

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()

    let targetFirmStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let targetFirmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let targetFirmDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let leadTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let leadTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let leadTypeLabelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    let createDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let createDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let createDateLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let sourceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let sourceLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let titleLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let leadAmountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let leadAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let leadAmountLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    let currencyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let currencyLabelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Lead Detail"
        setupUI()
        updateUI()

        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.4),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }

    func setupUI() {
        targetFirmStackView.addArrangedSubview(targetFirmLabel)
        targetFirmStackView.addArrangedSubview(targetFirmDescriptionLabel)
        targetFirmStackView.spacing = 8
        targetFirmStackView.alignment = .leading

        leadTypeStackView.addArrangedSubview(leadTypeLabel)
        leadTypeStackView.addArrangedSubview(leadTypeLabelDescription)
        leadTypeStackView.spacing = 8
        leadTypeStackView.alignment = .leading

        createDateStackView.addArrangedSubview(createDateLabel)
        createDateStackView.addArrangedSubview(createDateLabelDescription)
        createDateStackView.spacing = 8
        createDateStackView.alignment = .leading

        sourceStackView.addArrangedSubview(sourceLabel)
        sourceStackView.addArrangedSubview(sourceLabelDescription)
        sourceStackView.spacing = 8
        sourceStackView.alignment = .leading

        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleLabelDescription)
        titleStackView.spacing = 8
        titleStackView.alignment = .leading

        leadAmountStackView.addArrangedSubview(leadAmountLabel)
        leadAmountStackView.addArrangedSubview(leadAmountLabelDescription)
        leadAmountStackView.spacing = 8
        leadAmountStackView.alignment = .leading

        currencyStackView.addArrangedSubview(currencyLabel)
        currencyStackView.addArrangedSubview(currencyLabelDescription)
        currencyStackView.spacing = 5
        currencyStackView.alignment = .leading

        mainStackView.addArrangedSubview(targetFirmStackView)
        mainStackView.addArrangedSubview(leadTypeStackView)
        mainStackView.addArrangedSubview(createDateStackView)
        mainStackView.addArrangedSubview(sourceStackView)
        mainStackView.addArrangedSubview(titleStackView)
        mainStackView.addArrangedSubview(leadAmountStackView)
        mainStackView.addArrangedSubview(currencyStackView)
    }

    func updateUI() {
        guard let lead = lead else { return }
        targetFirmDescriptionLabel.text = "Target Firm: \(lead.customerName ?? "Veri Kaydı Gİrilmemiş")"
        leadTypeLabelDescription.text = "Lead Type: \(lead.leadDescription ?? "Veri Kaydı Gİrilmemiş")"
        createDateLabelDescription.text = "Create Date: \(lead.createDate ?? "Veri Kaydı Gİrilmemiş")"
        sourceLabelDescription.text = "Source: \(lead.resource ?? "Veri Kaydı Gİrilmemiş")"
        titleLabelDescription.text = "Title: \(lead.title ?? "Veri Kaydı Gİrilmemiş")"
        leadAmountLabelDescription.text = "Lead Amount: \(lead.leadAmount?.description ?? "Veri Kaydı Gİrilmemiş")"
        currencyLabelDescription.text = "Currency: \(lead.currencyType?.description ?? "Veri Kaydı Gİrilmemiş")"
    }
}
