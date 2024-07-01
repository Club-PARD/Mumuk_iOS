import UIKit

class FriendGroupingViewController: UIViewController {
    
    var uid: String?
    var name: String?
    
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupBackButton()
        setupSearchBar()
        setupFriendLabel()
    }
    
    func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = "함께 먹을 친구 찾기"
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 153),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 67)
        ])
    }
    
    func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31.79),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 68)
        ])
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "닉네임 검색"
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.layer.backgroundColor = UIColor(red: 0.961, green: 0.957, blue: 0.957, alpha: 1).cgColor
        searchBar.layer.cornerRadius = 20
        searchBar.clipsToBounds = true
        
        // Remove default search bar styling
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .clear
        
        // Set text color
        let textColor = UIColor(red: 0.571, green: 0.571, blue: 0.571, alpha: 1)
        searchBar.searchTextField.textColor = textColor
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "닉네임 검색", attributes: [NSAttributedString.Key.foregroundColor: textColor])
        
        // Set search icon color
        if let searchIconView = searchBar.searchTextField.leftView as? UIImageView {
            searchIconView.tintColor = textColor
        }
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: 330),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 121.01)
        ])
    }
    
    func setupFriendLabel() {
        let friendLabel = UILabel()
        friendLabel.textColor = UIColor(red: 0.706, green: 0.706, blue: 0.706, alpha: 1)
        friendLabel.font = UIFont(name: "Pretendard-Bold", size: 13)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.29
        
        friendLabel.textAlignment = .center
        friendLabel.attributedText = NSMutableAttributedString(string: "친구", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        view.addSubview(friendLabel)
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            friendLabel.widthAnchor.constraint(equalToConstant: 23),
            friendLabel.heightAnchor.constraint(equalToConstant: 20),
            friendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            friendLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 25) // searchBar 아래에 위치
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
