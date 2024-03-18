
import UIKit

protocol AddLeadDelegate: AnyObject {
    func didAddLead()
}
protocol AddLeadViewModelDelegate: AnyObject {
    func leadAddedSuccessfully()
    func addingLeadFailed(with error: Error)
}

class AddLeadViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, AddLeadViewModelDelegate {
    
    private let networkManager = NetworkManager.shared
    private var addLeadViewModel: AddLeadViewModel!
    weak var delegate: AddLeadDelegate?
    
    var parameterViewModel = ParameterViewModel()
    var currencyPickerView: UIPickerView?
    var leadStatusPickerView: UIPickerView?
    var leadTypePickerView: UIPickerView?
    var precedencePickerView: UIPickerView?
    var selectedDate: Date?
    var selectedCurrency: String?
    var selectedStatus: String?
    var selectedType: String?
    var selectedPrecedence: String?
    var currencyList: [[String]] = []
    var statuList: [[String]] = []
    var typeList: [[String]] = []
    var precedenceList: [[String]] = []
    var selectedCurrencyId: Int?
    var selectedStatusId: Int?
    var selectedTypeId: Int?
    var selectedPrecedenceId: Int?
    var associatedOfferName: String?

    
    
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //-----------------------StackViewlar-----------------------
    
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var hedefFirmaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var duyumTuruStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var olusturmaTarihiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var kaynakStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var baslikStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var aciklamaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var tahminiTutarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    var oncelikStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    //-----------------------Labellar-----------------------
    
    let hedefFirmaNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hedef Firma Adı"
        label.textColor = UIColor.black
        return label
    }()
    
    let duyumTuruLabel: UILabel = {
        let label = UILabel()
        label.text = "Duyum Türü"
        label.textColor = UIColor.black
        return label
    }()
    
    let olusturmaTarhiLabel: UILabel = {
        let label = UILabel()
        label.text = "Oluşturulma Tarihi"
        label.textColor = UIColor.black
        return label
    }()
    
    let kaynakLabel: UILabel = {
        let label = UILabel()
        label.text = "Kaynak"
        label.textColor = UIColor.black
        return label
    }()
    
    let baslikLabel: UILabel = {
        let label = UILabel()
        label.text = "Başlık"
        label.textColor = UIColor.black
        return label
    }()
    
    let aciklamaLabel: UILabel = {
        let label = UILabel()
        label.text = "Açıklama"
        label.textColor = UIColor.black
        return label
    }()
    
    let tahminiTutarLabel: UILabel = {
        let label = UILabel()
        label.text = "Tahmini Tutar"
        label.textColor = UIColor.black
        return label
    }()
    
    let paraBirimiLabel: UILabel = {
        let label = UILabel()
        label.text = "Para Birimi"
        label.textColor = UIColor.black
        return label
    }()
    
    let oncelikLabel: UILabel = {
        let label = UILabel()
        label.text = "Öncelik"
        label.textColor = UIColor.black
        return label
    }()
    
    let durumLabel: UILabel = {
        let label = UILabel()
        label.text = "Durum"
        label.textColor = UIColor.black
        return label
    }()
    
    //-----------------------TextFieldlar-----------------------
    
    let hedefFirmaTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Hedef Firma"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let kaynakTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Kaynak"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let baslikTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Başlık"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    let aciklamaTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let tahminiTutarTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Tutar Giriniz"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    let durumTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Durum Tipi"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let duyumTuruTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Duyum Tipi"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let paraBirimiTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Para Birimi"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let oncelikTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Öncelik Seçiniz"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    let kaydetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Kaydet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(kaydetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let olusturmaTarihiPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.isHidden = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.maximumDate = Date()
        datePicker.minimumDate = Date()
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Add New Lead"
        
        addLeadViewModel = AddLeadViewModel(networkManager: NetworkManager.shared)
        addLeadViewModel.delegate = self
        
        selectedDate = olusturmaTarihiPicker.date

        
        setupUI()
        setupPickerViews()
        
        currencyPickerView?.delegate = self
        currencyPickerView?.dataSource = self
        
        leadStatusPickerView?.delegate = self
        leadStatusPickerView?.dataSource = self
        
        leadTypePickerView?.delegate = self
        leadTypePickerView?.dataSource = self
        
        precedencePickerView?.delegate = self
        precedencePickerView?.dataSource = self
        
        paraBirimiTextField.inputView = currencyPickerView
        durumTextField.inputView = leadStatusPickerView
        duyumTuruTextField.inputView = leadTypePickerView
        oncelikTextField.inputView = precedencePickerView
        
        paraBirimiTextField.addTarget(self, action: #selector(paraBirimiTextFieldEditing), for: .touchDown)
        durumTextField.addTarget(self, action: #selector(durumTextFieldEditing), for: .touchDown)
        duyumTuruTextField.addTarget(self, action: #selector(duyumTuruTextFieldEditing), for: .touchDown)
        oncelikTextField.addTarget(self, action: #selector(oncelikTextFieldEditing), for: .touchDown)
        
        olusturmaTarihiPicker.isUserInteractionEnabled = false
        olusturmaTarihiPicker.isUserInteractionEnabled = false
        olusturmaTarihiPicker.setDate(Date(), animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardOrPicker))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        scrollView.addSubview(stackView)
        
        fetchCurrencyList()
        fetchStatusList()
        fetchTypeList()
        fetchPrecedenceList()
        
        
    }
    func fetchCurrencyList() {
        self.parameterViewModel.getCurrencyType { [weak self] currencyData in
            DispatchQueue.main.async {
                self?.currencyList = currencyData
                self?.currencyPickerView?.reloadAllComponents()
            }
        }
    }
    
    func fetchStatusList() {
        self.parameterViewModel.getLeadStatus { [weak self] statusData in
            DispatchQueue.main.async {
                self?.statuList = statusData
                self?.leadStatusPickerView?.reloadAllComponents()
            }
        }
    }
    
    func fetchTypeList() {
        self.parameterViewModel.getLeadTypes { [weak self] typeData in
            DispatchQueue.main.async {
                self?.typeList = typeData
                self?.leadTypePickerView?.reloadAllComponents()
            }
        }
    }
    
    func fetchPrecedenceList() {
        self.parameterViewModel.getPrecedence { [weak self] precedenceData in
            DispatchQueue.main.async {
                self?.precedenceList = precedenceData
                self?.precedencePickerView?.reloadAllComponents()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Lead Form"
        
        view.addSubview(scrollView)
        view.addSubview(stackView)
        
        hedefFirmaStackView.addArrangedSubview(hedefFirmaNameLabel)
        hedefFirmaStackView.addArrangedSubview(hedefFirmaTextField)
        
        duyumTuruStackView.addArrangedSubview(duyumTuruLabel)
        duyumTuruStackView.addArrangedSubview(duyumTuruTextField)
        
        olusturmaTarihiStackView.addArrangedSubview(olusturmaTarhiLabel)
        olusturmaTarihiStackView.addArrangedSubview(olusturmaTarihiPicker)
        olusturmaTarihiPicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

        
        kaynakStackView.addArrangedSubview(kaynakLabel)
        kaynakStackView.addArrangedSubview(kaynakTextField)
        
        baslikStackView.addArrangedSubview(baslikLabel)
        baslikStackView.addArrangedSubview(baslikTextField)
        
        tahminiTutarStackView.addArrangedSubview(tahminiTutarLabel)
        tahminiTutarStackView.addArrangedSubview(tahminiTutarTextField)
        tahminiTutarStackView.addArrangedSubview(paraBirimiLabel)
        tahminiTutarStackView.addArrangedSubview(paraBirimiTextField)
        
        oncelikStackView.addArrangedSubview(oncelikLabel)
        oncelikStackView.addArrangedSubview(oncelikTextField)
        oncelikStackView.addArrangedSubview(durumLabel)
        oncelikStackView.addArrangedSubview(durumTextField)
        
        stackView.addArrangedSubview(hedefFirmaStackView)
        stackView.addArrangedSubview(duyumTuruStackView)
        stackView.addArrangedSubview(olusturmaTarihiStackView)
        stackView.addArrangedSubview(kaynakStackView)
        stackView.addArrangedSubview(baslikStackView)
        
        setupAciklamaTextView()
        
        stackView.addArrangedSubview(tahminiTutarStackView)
        stackView.addArrangedSubview(oncelikStackView)
        stackView.addArrangedSubview(kaydetButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: view.bounds.width * 0.1),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -view.bounds.width * 0.1),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -view.bounds.width * 0.2),
        ])


        scrollView.contentSize = CGSize(width: view.bounds.width, height: stackView.frame.maxY + 16)

        
    }
    
    private func setupPickerViews() {
        currencyPickerView = UIPickerView()
        leadStatusPickerView = UIPickerView()
        leadTypePickerView = UIPickerView()
        precedencePickerView = UIPickerView()
    }
    
    func setupAciklamaTextView() {
        aciklamaStackView.addArrangedSubview(aciklamaLabel)
        aciklamaStackView.addArrangedSubview(aciklamaTextView)
        aciklamaTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        aciklamaTextView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == aciklamaTextView {
            aciklamaLabel.isHidden = !textView.text.isEmpty
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == currencyPickerView {
            return currencyList.count
        }else if pickerView == leadStatusPickerView {
            return statuList.count
        }else if pickerView == leadTypePickerView {
            return typeList.count
        }else if pickerView == precedencePickerView {
            return precedenceList.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == currencyPickerView {
            return currencyList[row].first
        }else if pickerView == leadStatusPickerView {
            return statuList[row].first
        }else if pickerView == leadTypePickerView {
            return typeList[row].first
        }else if pickerView == precedencePickerView {
            return precedenceList[row].first
        }else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currencyPickerView {
            paraBirimiTextField.text = currencyList[row][0]
            selectedCurrencyId = Int(currencyList[row][1])
            paraBirimiTextField.resignFirstResponder()
        }else if pickerView == leadStatusPickerView {
            durumTextField.text = statuList[row][0]
            selectedStatusId = Int(statuList[row][1])
            durumTextField.resignFirstResponder()
        }else if pickerView == leadTypePickerView {
            duyumTuruTextField.text = typeList[row][0]
            selectedTypeId = Int(typeList[row][1])
            duyumTuruTextField.resignFirstResponder()
        }else if pickerView == precedencePickerView {
            oncelikTextField.text = precedenceList[row][0]
            selectedPrecedenceId = Int(precedenceList[row][1])
            oncelikTextField.resignFirstResponder()
        }
    }
    
    @objc private func kaydetButtonTapped() {
        let associatedOfferName = "associatedOfferName"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: selectedDate!)
        let createDate = formattedDate

        guard let customerName = hedefFirmaTextField.text,
              let currencyTypeId = selectedCurrencyId,
              let leadTypeId = selectedTypeId,
              let leadAmount = Double(tahminiTutarTextField.text!),
              let resource = kaynakTextField.text,
              let precedenceId = selectedPrecedenceId,
              let title = baslikTextField.text,
              let description = aciklamaTextView.text,
              let userEmail = UserDefaults.standard.string(forKey: "userEmail"),
              let leadStatusId = selectedStatusId,
              let status = false as Bool?
                
        else {
            displayErrorAlert(message: "Lütfen tüm alanları doldurun.")
            return
        }

        addLeadViewModel.addLead(
            customerName: customerName,
            currencyTypeId: currencyTypeId,
            leadTypeId: leadTypeId,
            leadAmount: leadAmount,
            createDate: formattedDate,
            resource: resource,
            precedenceId: precedenceId,
            title: title,
            description: description,
            userEmail: userEmail,
            leadStatusId: leadStatusId,
            status: status,
            associatedOfferName: associatedOfferName
        ) { result in
            switch result {
            case .success(let success):
                print(success)
                self.delegate?.didAddLead()
                self.navigationController?.popViewController(animated: true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }

    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
    }
    
    @objc private func paraBirimiLabelTapped() {
        paraBirimiTextField.becomeFirstResponder()
    }
    
    @objc private func durumLabelTapped() {
        durumTextField.becomeFirstResponder()
    }
    
    @objc private func duyumLabelTapped() {
        duyumTuruTextField.becomeFirstResponder()
    }
    @objc private func oncelikLabelTapped() {
        oncelikTextField.becomeFirstResponder()
    }
    
    @objc private func paraBirimiTextFieldEditing() {
        currencyPickerView?.reloadAllComponents()
    }
    
    @objc private func durumTextFieldEditing() {
        leadStatusPickerView?.reloadAllComponents()
    }
    
    @objc private func duyumTuruTextFieldEditing() {
        leadTypePickerView?.reloadAllComponents()
    }
    
    @objc private func oncelikTextFieldEditing() {
        precedencePickerView?.reloadAllComponents()
    }
    
    @objc private func dismissKeyboardOrPicker() {
        view.endEditing(true)
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func leadAddedSuccessfully() {
        print("Lead added successfully")
    }
    
    func addingLeadFailed(with error: Error) {
        print("Error adding employee: \(error.localizedDescription)")
    }
}
