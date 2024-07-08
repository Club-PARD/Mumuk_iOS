//
//  FriendViewController.swift
//  mumuk
//
//  Created by 유재혁 on 6/29/24.
//

import UIKit


class FriendViewController: UIViewController{
    
    // 데이터 전달을 위해 추가함 
    var uid : String?
    var name : String?
    
    
    
    
    var friend: [FriendModel] = []    // memos 배열
    var filteredFriends: [FriendModel] = [] // 검색된 친구 목록
    var isSearching = false
    
    var filteredExampleModel: [[ExampleModel]] = []     //임시 데이터 검색,삭제

    //    static let URL_GET_MEMBERS = "https://pard-host.onrender.com/pard"  // 데이터 가져오기위한 api주소
    
    let homeTitle: UILabel =  {
        let label = UILabel()
        label.text = "친구 찾기"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // 버튼 생성
    let addfriend: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapModalButton), for: .touchUpInside)
        
        if let image = UIImage(named: "addfriend") {
            let resizedImage = image.resized(to: CGSize(width: 36, height: 36))
            button.setImage(resizedImage, for: .normal)
        }
        
        return button
    }()
    
    //검색창
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "닉네임 검색"
//        searchBar.searchTextField.textColor = #colorLiteral(red: 0.6394036412, green: 0.6394036412, blue: 0.6394036412, alpha: 1)
//        searchBar.backgroundColor = #colorLiteral(red: 0.9688948989, green: 0.9657412171, blue: 0.9656746984, alpha: 1)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal // 검색창의 형태 최대한 간소화
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false //서치바 안에 searchTextField가 존재한다
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 0)   //돋보기와 텍스트 상자 간격 조절
        
        // 돋보기 이미지 위치 조절
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            let image = UIImage(systemName: "magnifyingglass")
            imageView.image = image
            imageView.tintColor = .gray
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20)) // 패딩 뷰 생성
            paddingView.addSubview(imageView)
            imageView.center = CGPoint(x: paddingView.frame.size.width - 13, y: paddingView.frame.size.height / 2)
            
            searchTextField.leftView = paddingView
        }
        
        return searchBar
    }()
    
    
    //tableview생성
    private lazy var friendTableView: UITableView = {     // lazy : 값이 계속 바뀔 수 있을 때 사용
        let tableView = UITableView(frame: .zero, style: .plain)    //header함께 움직임
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FriendComponent.self, forCellReuseIdentifier: "FriendViewController")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {    //뷰가 뜰 때 실행되는 함수
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)      //이거hiddend을  true로 해서 움직일 때 위에 색 바뀌는거 없애줌
    }
    
    override func viewWillDisappear(_ animated: Bool) { // 뷰가 사라질 때 실행되는 함수
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(uid)
        view.backgroundColor = .white
        
        _ = ExampleModelData.modeling

        
        
        //아래 가려지는거 없애보려는 중
        friendTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 셀 사이의 간격 설정
        friendTableView.register(FriendComponent.self, forCellReuseIdentifier: "FriendComponent")
        friendTableView.dataSource = self
        friendTableView.delegate = self
        
        view.addSubview(friendTableView)
        view.addSubview(homeTitle)
        view.addSubview(addfriend)
        view.addSubview(searchBar)
        addConstraints()
//        fetchMembers()
        
        
        // TabBar 높이 만큼 contentInset 설정
        if let tabBarHeight = tabBarController?.tabBar.frame.height {
            friendTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight/2, right: 0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let tabBarHeight = tabBarController?.tabBar.frame.height {
            friendTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarHeight/2, right: 0)
        }
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            friendTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 162),
            friendTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            //            friendTableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            friendTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            homeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 66),
            homeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            addfriend.topAnchor.constraint(equalTo: view.topAnchor, constant: 113),
            addfriend.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            addfriend.heightAnchor.constraint(equalToConstant: 36),
            addfriend.widthAnchor.constraint(equalToConstant: 36),
            
            searchBar.centerYAnchor.constraint(equalTo: addfriend.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -77),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
            
        ])
    }
    
    
    
    
    // 친구 추가 버튼 누를 때
    @objc func tapModalButton() {
        let alertController = UIAlertController(title: "추가할 친구의 아이디를 입력해주세요.", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "아이디"
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            if let textField = alertController.textFields?.first, let id = textField.text {
                print("입력된 아이디: \(id)")
                self?.friendCheckRequest(id)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    //친구추가 했을 때 있는 닉네임인지
    func friendCheckRequest(_ id: String) {
        guard let encodedId = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://mumuk.store/user/checkExists?name=\(encodedId)") else {
            print("🚨 Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  //
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("네트워크 에러: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.showAlert(message: "네트워크 오류: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                print("데이터가 없음")
                DispatchQueue.main.async {
                    self?.showAlert(message: "서버에서 데이터를 받지 못했습니다.")
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("서버 응답: \(responseString)")
                
                let trimmedResponse = responseString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if let responseBool = Bool(trimmedResponse) {
                    DispatchQueue.main.async {
                        if responseBool {
                            let currentUserName = "ssss" // 실제 사용자 이름으로 대체
                            self?.makePostRequest(id: id, name: currentUserName)
                        } else {
                            self?.showAlert(message: "존재하지 않는 닉네임입니다.")
                        }
                    }
                } else {
                    print("응답을 Bool로 변환할 수 없음: \(responseString)")
                    DispatchQueue.main.async {
                        self?.showAlert(message: "서버 응답을 처리할 수 없습니다.")
                    }
                }
            } else {
                print("응답을 문자열로 변환할 수 없음")
                DispatchQueue.main.async {
                    self?.showAlert(message: "서버 응답을 처리할 수 없습니다.")
                }
            }
        }
        
        task.resume()
    }
//    
    
    
    // Post request 보내는 함수
    func makePostRequest(id: String, name: String) {
        guard let url = URL(string: "https://mumuk.store/friend/add?userName=\(name)&friendName=\(id)") else {
            print("🚨 Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ["id": id, "name": name]
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(requestBody)
            request.httpBody = jsonData
            
            // 디버깅: 요청 내용 출력
            print("Request Body: \(String(data: jsonData, encoding: .utf8) ?? "")")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("🚨 Network Error:", error)
                } else if let httpResponse = response as? HTTPURLResponse {
                    print("Response Status Code: \(httpResponse.statusCode)")
                    if let data = data, let responseString = String(data: data, encoding: .utf8) {
                        print("Response Body: \(responseString)")
                        
                        DispatchQueue.main.async {
                            switch httpResponse.statusCode {
                            case 200:
                                self.showAlert(message: "친구가 추가되었습니다.")
//                                self.fetchMembers()
                            case 409:
                                self.showAlert(message: "이미 추가된 사람입니다.")
                            default:
                                self.showAlert(message: "서버 오류: 상태 코드 \(httpResponse.statusCode)")
                            }
                        }
                    }
                }
            }
            task.resume()
        } catch {
            print("🚨 Encoding Error:", error)
        }
    }
    
    // 경고창 표시 함수
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
//    // 데이터 불러오기 함수 (친구 목록 갱신)
//    func fetchMembers() {
//        print("데이터 불러오기 시작")
//        if let url = URL(string: "http://172.30.1.21:8080/friend/유재혁") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if error != nil {
//                    print("🚨🚨🚨", error!)
//                    return
//                }
//                if let JSONdata = data {
//                    let dataString = String(data: JSONdata, encoding: .utf8)
//                    print(dataString!)
//                    
//                    let decoder = JSONDecoder()
//                    do {
//                        let decodeData = try decoder.decode([NameModel].self, from: JSONdata)
//                        self.friend = decodeData
//                        DispatchQueue.main.async {
//                            self.friendTableView.reloadData()
//                        }
//                    } catch let error as NSError {
//                        print("🚨🚨🚨", error)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
}


// 검색 위한 delegate
extension FriendViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            isSearching = false
//            filteredFriends.removeAll()
//        } else {
//            isSearching = true
//            filteredFriends = friend.filter { $0.name.contains(searchText) }
//        }
//        friendTableView.reloadData()
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFriends(with: searchText)
    }
    
    //서치바 검색 x버튼 누르면 초기화
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredFriends.removeAll()
        friendTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    //빈화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    
}


extension FriendViewController: UITableViewDataSource, UITableViewDelegate {
    //    // 섹션 수 반환
//        func numberOfSections(in tableView: UITableView) -> Int {
//            return isSearching ? filteredFriends.count : friend.count
//        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? filteredExampleModel.count : ExampleModelData.modeling.count
    }
    
    // 각 섹션에 대한 행 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("cellForRowAt")
//        guard let cell = friendTableView.dequeueReusableCell(withIdentifier: "FriendViewController", for: indexPath) as? FriendComponent else {
//            return UITableViewCell()
//        }
//        
//        let memo = isSearching ? filteredFriends[indexPath.row] : friend[indexPath.row] // 여기도 단순히 row수가 아니라 검색도 추가
//        cell.configure(with: memo)
//        return cell
//    }
    
    
    //검색 도전 중인거
    func searchFriends(with searchText: String) {
        if searchText.isEmpty {
            filteredExampleModel = ExampleModelData.modeling
        } else {
            filteredExampleModel = ExampleModelData.modeling.map { section in
                section.filter { friend in
                    friend.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
        friendTableView.reloadData()
    }
    
    
    
    //더미 데이터로 하는 중
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendComponent", for: indexPath) as? FriendComponent else {
            return UITableViewCell()
        }

        let friendsInSection = isSearching ? filteredExampleModel[indexPath.section] : ExampleModelData.modeling[indexPath.section]
        
        if indexPath.row < friendsInSection.count {
            let friend = friendsInSection[indexPath.row]
            cell.configure(with: friend)
            cell.detailController = self  // 프로필 상세 누르면 모달 뜨게 하기 위해서 여기에 추가
        } else {
            // 데이터가 없는 경우 기본값 설정
            cell.configure(with: ExampleModel(name: "", tags: [], user: "", image: ""))
            cell.detailController = self  // 프로필 상세 누르면 모달 뜨게 하기 위해서 여기에 추가
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
//     editingStyle 삭제하면 없어지게 하는거
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            // 해당 섹션에서 행 삭제
            ExampleModelData.modeling[indexPath.section].remove(at: indexPath.row)
            
            // 섹션이 비어있다면 섹션도 삭제
            if ExampleModelData.modeling[indexPath.section].isEmpty {
                ExampleModelData.modeling.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            // 변경사항 저장
            ExampleModelData.saveModeling()
            
            tableView.endUpdates()
        }
    }
    
    
    //cell의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    //
    //
    //        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //            let memo = memos[indexPath.row]
    //
    //            let detailViewController = DetailViewController()
    //            detailViewController.memo = memo
    //            detailViewController.viewController = self
    //
    //            present(detailViewController, animated: true, completion: nil)
    //        }
    //
    
}

//이미지 크기 조절 하기 위해서
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}


