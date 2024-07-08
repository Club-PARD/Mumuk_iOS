import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class KakaoLoginViewController: UIViewController {
    
    var memos: [NameModel] = []
    var nickname : String?
    var uid : String?
    var exists : Bool?
    static var globalUid : String = ""
    
    let superTitle1 : UILabel = {
        let label = UILabel()
        label.text = "고르다 지친 당신을 위한"
        label.font = UIFont(name: "Pretendard-Medium", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let superTitle2 : UILabel = {
        let label = UILabel()
        label.text = "메뉴 추천 플랫폼"
        label.font = UIFont(name: "Pretendard-Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    

    
    let titleImage : UIImageView = {
        let titleImage = UIImageView()
        
        titleImage.image = UIImage(named: "MUMUK")
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.contentMode = .scaleAspectFit
        return titleImage
    }()
    
    
    
    let mainImage : UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "mainImage")
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        return mainImage
    }()
    
    
    let kakaoLoginButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 1, green: 0.8935882449, blue: 0, alpha: 1)
        config.image = UIImage(named: "kakaoLogo")
        config.imagePadding = 12
        // 내부 여백 설정
        config.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 67, bottom: 15, trailing: 67)
        
        config.title = "카카오톡으로 시작하기"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-Medium", size: 18)
            outgoing.foregroundColor = UIColor.black
            return outgoing
        }
        
        var button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        
        
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        NotificationController.requestNotificationAuthorization()
//        NotificationController.scheduleDailyNotification()
//        NotificationController.scheduleNotification()
//        
        
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        
        view.addSubview(superTitle1)
        view.addSubview(superTitle2)
        view.addSubview(titleImage)
        view.addSubview(mainImage)
        view.addSubview(kakaoLoginButton)
        
        
        
        kakaoLoginButton.addTarget(self, action: #selector(loginAction) , for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            superTitle1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            superTitle1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 62),
            
            
            superTitle2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            superTitle2.topAnchor.constraint(equalTo: superTitle1.bottomAnchor),
            
            titleImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            titleImage.topAnchor.constraint(equalTo: superTitle2.bottomAnchor, constant: 10),
            titleImage.heightAnchor.constraint(equalToConstant: 40),
            titleImage.widthAnchor.constraint(equalToConstant: 183),
            
            
            
            mainImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75),
            mainImage.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 109),
            
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 54),
            kakaoLoginButton.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 84),
            kakaoLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
        ])
    }
    
    
    // 카카오 API를 사용하여 사용자 정보 가져오기
    private func setUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            } else {
                
                self.nickname = user?.kakaoAccount?.profile?.nickname ?? "no nickname"
                self.uid = String(user?.id ?? 0)
                // 잘 가져왔는지 확인
//                print(self.nickname ?? 0)
//                print(self.userId ?? 0)
//                print("🟢")
//                print(self.exists ?? nil)
                self.checkUid()
                
                
                
                
            }
        }
    }
    
    
    //카카오 앱을 통한 로그인 시도 : 카카오 앱 설치 유무 확인후 앱이 존재하면 앱으로 로그인, 없으면 웹으로 로그인
    @objc private func loginAction() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                    self.setUserInfo()
                }
            }
        } else {
            // 카카오톡이 설치되어 있지 않은 경우 웹 로그인을 시도할 수 있습니다.
            self.loginWithKakaoAccount()
        }
    }
    
    
    // 카카오 계정을 통해 웹 로그인
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                _ = oauthToken
                self.setUserInfo()
            }
        }
    }
    
    
    
    // MARK: - 서버 통신 메소드
        
    func checkUid() {
        guard let uid = self.uid else {
            print("🚨Error: userId is nil")
            return
        }
        
        guard let url = URL(string: "https://mumuk.store/user/checkExists?uid=\(uid)") else {
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
                
                DispatchQueue.main.async {
                    self?.exists = exists
                    print("✅ User exists:", exists)
                    
                    if exists {
                        print("User already exists")
                        // 기존 사용자에 대한 처리
                        self?.moveToMainViewController()
                        
                    } else {
                        print("New user")
                        // 새 사용자에 대한 처리
                        self?.moveToLoginController()
                    }
                }
            } else {
                print("🚨 Unable to convert data to string")
            }
        }
        
        task.resume()
    }
    
    
    //MARK: - 화면 이동 메소드
    //    메인 화면으로 이동
    func moveToMainViewController() {
        
        let nextVC = TabbarViewController()
        if let uid = uid {
         KakaoLoginViewController.globalUid = uid
        }
    
        nextVC.modalPresentationStyle = .fullScreen
//        nextVC.uid = self.ui
        present(nextVC, animated: true, completion: nil)
    }
    
    
    func moveToLoginController() {
        let nextVC = LoginController()
        nextVC.modalPresentationStyle = .fullScreen
        
        present(nextVC, animated: true, completion: nil)
    }
    
}




