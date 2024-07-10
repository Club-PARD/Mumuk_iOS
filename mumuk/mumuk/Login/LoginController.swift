//
//  LoginController.swift
//  mumuk
//
//  Created by 유재혁 on 6/24/24.
//

import UIKit

class LoginController: UIViewController, ModalImageSelectDelegate {
    var memos: [NameModel] = []    // memos 배열
    var selectedIndex: Int? = 0
    var uid : String?
    var roundedImageButton: CustomImageField!
    var exists : Bool?
    var name: String?
    
    static var globalName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupRoundedImageButton()
        
        print("로그인 페이지 : \(uid)")
        
        setUI()
    }

    private var LoginTitle: UILabel =  {
        let label = UILabel()
        label.text = "회원 정보를 \n등록해주세요"
        label.font = UIFont(name: "Pretendard-Thin", size: 30)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    
    private lazy var idField: CustomTextField = {
        let textField = CustomTextField()
        
        return textField
    }()

    
    let LoginButton : UIButton = {
        let label = UIButton()
        //자동 오토레이징 마스크제한 팔스
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitle("다음 〉", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.backgroundColor = #colorLiteral(red: 1, green: 0.5921088457, blue: 0.1072979197, alpha: 1)
        label.addTarget(self, action: #selector(LoginButtonPressed), for: .touchUpInside)
        // labelview의 외부 데코레이션
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 1, green: 0.5921088457, blue: 0.1072979197, alpha: 1)
        return label
    }()
    
    let nickName: UILabel =  {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont(name: "Pretendard-Light", size: 15)
        label.textColor = .black
        return label
    }()

    //회원정보 사진 초기화 및 설정
    func setupRoundedImageButton() {
        let customImageField = CustomImageField()
        customImageField.setImageWithName(selectedIndex ?? 0)
        roundedImageButton = customImageField
    }
    
    
    private let modalButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.layer.masksToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.9067616463, green: 0.9017952085, blue: 0.9018836617, alpha: 1)
        button.addTarget(self, action: #selector(tapModalButton), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.layer.borderColor = UIColor.white.cgColor  // 하얀색 테두리 색상 설정
        button.layer.borderWidth = 5.0  // 테두리 두께 설정
        return button
    }()
    
    
    private let containerView: UIView = {
         let view = UIView()
         return view
     }()
    
    private func setUI() {

        view.addSubview(LoginTitle)
        view.addSubview(idField)
        view.addSubview(LoginButton)
        view.addSubview(nickName)
        view.addSubview(containerView) // containerView 추가
        containerView.addSubview(roundedImageButton) // roundedImageButton을 containerView에 추가
        containerView.addSubview(modalButton) // modalButton을 containerView에 추가


        LoginTitle.translatesAutoresizingMaskIntoConstraints = false
        idField.translatesAutoresizingMaskIntoConstraints = false
        LoginButton.translatesAutoresizingMaskIntoConstraints = false
        nickName.translatesAutoresizingMaskIntoConstraints = false
        roundedImageButton.translatesAutoresizingMaskIntoConstraints = false
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([

            LoginTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            LoginTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            LoginTitle.widthAnchor.constraint(equalToConstant: 156),
            LoginTitle.heightAnchor.constraint(equalToConstant: 80),
            
            nickName.topAnchor.constraint(equalTo: view.topAnchor, constant: 379),
            nickName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            idField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            idField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            idField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            idField.heightAnchor.constraint(equalToConstant: 35),
            
            LoginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 442),
            LoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            LoginButton.heightAnchor.constraint(equalToConstant: 40.63),
            LoginButton.widthAnchor.constraint(equalToConstant: 87),
            
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 219),
            containerView.widthAnchor.constraint(equalToConstant: 118),
            containerView.heightAnchor.constraint(equalToConstant: 118),
             
            roundedImageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            roundedImageButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            roundedImageButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            roundedImageButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
             
            modalButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            modalButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            modalButton.widthAnchor.constraint(equalToConstant: 34),
            modalButton.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
    
//     로그인하기 버튼이 눌렸을 때
    @objc private func LoginButtonPressed() {
        print("Login button tapped!")
        
        guard let name = idField.text, !name.isEmpty,
              let image = selectedIndex else {
            showAlert(title: "입력 오류", message: "닉네임을 올바르게 입력해주세요.")
            return
        }
        guard name.count >= 2 && name.count <= 6 else {
                showAlert(title: "입력 오류", message: "닉네임은 2글자에서 6글자 사이여야 합니다.")
                return
            }
        
        let noSpaces = name.replacingOccurrences(of: " ", with: "")

        //서버에 name이 존재하는 지 확인하고 있으면 alert 띄우고 없으면 POST 하기
        checkNameExists(name: noSpaces, image: image)
    }

    
    // alert 창 설정
    private func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) // 여기가 alert창 만드는 부분
        let check = UIAlertAction(title: "확인", style: .default, handler: nil)   // 이건 alert창에 넣을 값 만들어 주는 곳
//        let close = UIAlertAction(title: "닫기", style: .destructive, handler: nil)     // 이건 닫기버튼 만들기.
        
        alert.addAction(check)
        present(alert, animated: true, completion: nil)
        
    }
    
    private func showCustomAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        
        let containerView = UIView()
        containerView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        alert.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            containerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50)
        ])
        
        let check = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(check)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @objc func tapModalButton() {
        //키보드 내리기
        view.endEditing(true)
        
        let ModalImageSelect = ModalImageSelect()
        ModalImageSelect.modalPresentationStyle = .formSheet
        
        // detent 설정
        if let sheet = ModalImageSelect.sheetPresentationController {
            // detents 배열을 설정하여 원하는 위치에 맞게 모달 창의 위치를 조정할 수 있습니다.
            sheet.detents = [
                .custom { _ in
                    return 550  //이 숫자로 원하는 만큼 조절가능
                }
            ]
            
            sheet.preferredCornerRadius = 40 // 모달 창의 모서리 둥글기 설정
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = true // full일 때 스크롤 시 창 크기 조정
            
            // roundedImageButton에서 이미지를 가져와서 modalImageSelect의 selectedImage에 설정
            ModalImageSelect.selectedImage = roundedImageButton.image
            ModalImageSelect.delegate = self // delegate 설정
            
            // 모달을 present
            present(ModalImageSelect, animated: true)
        }
    }

    func didSelectImage(withNumber number: Int) {
        print("Selected image number: \(number)")
        selectedIndex = number
        
        // 이미지 새로고침
        roundedImageButton.setImageWithName(selectedIndex ?? 0)
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    
    // 서버에 이미 존재하는 이름인지 확인하기
    func checkNameExists(name: String, image: Int) {
        guard let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://mumuk.store/user/checkExists?name=\(encodedName)") else {
            print("🚨Error: Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("🚨 Network error:", error)
                return
            }
            
            guard let data = data else {
                print("🚨 No data received")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Server response: \(responseString)")
                
                let exists = responseString.lowercased() == "true"
                
                DispatchQueue.main.async { [self] in
                    self?.exists = exists
                    print("✅ User with name '\(name)' exists:", exists)
                    
                    if exists {
                        print("User with name '\(name)' already exists")
                        // 기존 사용자에 대한 처리
                        self?.showCustomAlert(title: "중복 닉네임", message: "이미 사용 중인 닉네임입니다.\n다른 닉네임을 선택해주세요.")
                    } else {
                        print("User with name '\(name)' is new")
                    
                        // 새 사용자에 대한 처리
                        let newMember = NameModel(uid: self?.uid ?? "", name: name, imageId: image)
                        self?.makePostRequest(newMember)
                        self!.name = newMember.name
                        
                        // 전역변수로 name
                        LoginController.globalName = newMember.name
                        
                        print("이거 확인\(name)")
                    }
                }
            } else {
                print("🚨 Unable to convert data to string")
            }
        }
        
        task.resume()
    }

    
    
    
    
    
    
    
    // Post request 보내는 함수
       func makePostRequest(_ memo: NameModel) {
           guard let url = URL(string: "https://mumuk.store/user/create") else {
               print("🚨 Invalid URL")
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           do {
               let encoder = JSONEncoder()
               let jsonData = try encoder.encode(memo)
               request.httpBody = jsonData
               
               let task = URLSession.shared.dataTask(with: request) { data, response, error in
                   if let error = error {
                       print("🚨", error)
                   } else if let data = data {
                       if let responseString = String(data: data, encoding: .utf8) {
                           print("✅Response: \(responseString)")
                           DispatchQueue.main.async {
                               self.navigateToNextViewController()
                           }
                       }
                   }
               }
               task.resume()
           } catch {
               print("🚨", error)
           }
       }

    // 화면 이동하기
    func navigateToNextViewController() {
        let nextVC = OpenPreferViewController1()
        nextVC.uid = self.uid
        
                
        nextVC.name = self.name
        print(name)
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    
    
    //빈화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
}

    
