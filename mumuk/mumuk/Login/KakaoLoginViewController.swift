import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class KakaoLoginViewController: UIViewController {
    private let nickNameLabel = UILabel()
    private let emailLabel = UILabel()
    
    private let kakaoLoginButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        kakaoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(nickNameLabel)
        view.addSubview(emailLabel)
        view.addSubview(kakaoLoginButton)
        view.addSubview(logoutButton)

        kakaoLoginButton.setTitle("Kakao Login", for: .normal)
        kakaoLoginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            nickNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nickNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 20),

            kakaoLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoLoginButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40),

            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor, constant: 20)
        ])
    }

    private func setUserInfo() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
                print("email: \(user?.kakaoAccount?.email ?? "no email")")
                guard let userId = user?.id else { return }
                print("닉네임: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname").....이메일: \(user?.kakaoAccount?.email ?? "no email").....유저 ID: \(userId)")
                
                DispatchQueue.main.async {
                    self.nickNameLabel.text = "Nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")"
                    self.emailLabel.text = "Email: \(user?.kakaoAccount?.email ?? "no email")"
                }
            }
        }
    }

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

    @objc private func logoutAction() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            } else {
                print("kakao logout success")
                DispatchQueue.main.async {
                    self.nickNameLabel.text = "Nickname: "
                    self.emailLabel.text = "Email: "
                }
            }
        }
    }
}
