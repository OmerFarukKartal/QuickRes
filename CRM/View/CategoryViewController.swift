import UIKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func didSelectCategory(_ categoryInfo: CategoryInfo, at indexPath: IndexPath)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCell"
    
    var categoryImageView: UIImageView!
    var categoryNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        categoryImageView = UIImageView()
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryImageView)
        
        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        categoryNameLabel = UILabel()
        categoryNameLabel.textColor = .white
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryNameLabel)
        
        NSLayoutConstraint.activate([
            categoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryNameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10),
            categoryNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = frame.width / 0.0
        backgroundColor = .clear
        
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.clipsToBounds = true
        categoryNameLabel.textAlignment = .center
        categoryNameLabel.textColor = .white
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            categoryNameLabel.font = UIFont.systemFont(ofSize: 14)
        } else {
            categoryNameLabel.font = UIFont.systemFont(ofSize: 20)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with categoryInfo: CategoryInfo) {
        categoryImageView.image = categoryInfo.image
        categoryNameLabel.text = categoryInfo.name
    }
}
struct CategoryInfo {
    let name: String
    let image: UIImage
}

class CategoriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: CategoriesViewControllerDelegate?

    
    var categories: [CategoryInfo] = [
        CategoryInfo(name: "Employee", image: UIImage(named: "employeeIcon") ?? UIImage()),
        CategoryInfo(name: "Firms", image: UIImage(named: "firmsIcon") ?? UIImage()),
        CategoryInfo(name: "Lead", image: UIImage(named: "leadIcon") ?? UIImage()),
        CategoryInfo(name: "Expense", image: UIImage(named: "allExpenceIcon") ?? UIImage()),
        CategoryInfo(name: "Personel Expense", image: UIImage(named: "expenseIcon") ?? UIImage())
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        view.backgroundColor = UIColor(#colorLiteral(red: 0.2549019608, green: 0.2470588235, blue: 0.2588235294, alpha: 1))
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        let categoryInfo = categories[indexPath.item]
        cell.configure(with: categoryInfo)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width * 0.2
        return CGSize(width: cellWidth, height: cellWidth + 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.bounds.width * 0.08
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return view.bounds.width * 0.08
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: view.bounds.width * 0.08, left: view.bounds.width * 0.08, bottom: view.bounds.width * 0.08, right: view.bounds.width * 0.08) 
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        
        switch indexPath.item {
        case 0:
            let employeeListViewController = EmployeeListViewController()
            navigationController?.pushViewController(employeeListViewController, animated: true)
        case 1:
            let firmListViewController = FirmListViewController()
            navigationController?.pushViewController(firmListViewController, animated: true)
        case 2:
            let leadViewController = LeadListViewController()
            navigationController?.pushViewController(leadViewController, animated: true)
        case 3:
            let expenseViewController = ExpenseViewController()
            navigationController?.pushViewController(expenseViewController, animated: true)
        default:
            break
        }
    }}
