//
//  ServiceViewController.swift
//  mumuk
//
//  Created by 유재혁 on 7/10/24.
//

import UIKit

class ServiceViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollViews = UIScrollView()
        scrollViews.translatesAutoresizingMaskIntoConstraints = false
        scrollViews.backgroundColor = .white
        return scrollViews
    }()
    
    let contentView: UIView = {
        let contents = UIView()
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.backgroundColor = .white
        return contents
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }

    
    func setUI() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(contentView)
        contentView.addSubview(termsLabel)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            scrollView.topAnchor.constraint(equalTo: closeButton.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            termsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        termsLabel.text = """
               머먹 (MUMUK) 이용약관

               1. 서비스 소개
                  "머먹"은 여러 명이 함께 식사 메뉴를 고를 때 개인의 선호를 반영하여 식사메뉴를 추천해주는 서비스입니다.

               2. 이용계약의 성립
                  본 서비스 이용계약은 이용자가 본 약관에 동의하고 회사가 승낙함으로써 성립됩니다.

               3. 개인정보 보호
                  회사는 이용자의 개인정보를 보호하기 위해 최선을 다합니다. 개인정보 수집 및 이용에 관한 자세한 사항은 개인정보 처리방침을 참조하시기 바랍니다.

               4. 서비스 이용
                  - 이용자는 본인의 음식 선호도, 알레르기 정보 등을 정확하게 입력해야 합니다.
                  - 타인의 정보를 무단으로 사용하거나 허위정보를 입력해서는 안 됩니다.

               5. 지식재산권
                  서비스 내 모든 콘텐츠에 대한 지식재산권은 회사에 귀속됩니다.

               6. 서비스 변경 및 중단
                  회사는 운영상, 기술상의 필요에 따라 서비스를 변경하거나 중단할 수 있습니다.

               7. 이용자의 의무
                  - 이용자는 타인의 권리를 침해하거나 법령에 위반되는 행위를 해서는 안 됩니다.
                  - 서비스를 부정한 목적으로 이용해서는 안 됩니다.

               8. 책임제한
                  회사는 천재지변, 전쟁 등 불가항력적인 사유로 인한 서비스 중단에 대해 책임을 지지 않습니다.

               9. 준거법 및 관할법원
                  본 약관은 대한민국 법률에 따라 규율되며, 분쟁 발생 시 회사의 주소지를 관할하는 법원을 관할법원으로 합니다.

               10. 기타
                   본 약관에 명시되지 않은 사항은 관련법령 및 회사의 정책에 따릅니다.

               이용약관 최종 수정일: [2024년 7월 10일]
               """
    }
}
