import UIKit

class SummaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSummaryView()
    }

    func setupSummaryView() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 107)
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 107).isActive = true
        view.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 75).isActive = true

        // Summary 이미지 추가
        let summaryImageView = UIImageView(image: UIImage(named: "Summary"))
        summaryImageView.contentMode = .scaleAspectFit
        view.addSubview(summaryImageView)
        
        summaryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryImageView.topAnchor.constraint(equalTo: view.topAnchor),
            summaryImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            summaryImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
