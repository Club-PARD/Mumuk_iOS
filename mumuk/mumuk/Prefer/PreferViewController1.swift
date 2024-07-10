//
//  PreferViewController1.swift
//  mumuk
//
//  Created by 김민준 on 7/2/24.
//
import UIKit


class PreferViewController1 : UIViewController , UISearchBarDelegate{
//    var uid : String = "262885"
    var uid : String?
    var name: String?
    
    var foodList  : [FoodListModel] = []
    let searchBar = UISearchBar()
    var searchText: String = ""

    var food : [String] = []
    var filteredFood: [String] = []
    

    
    var dailyScrumModel : PreferModel = PreferModel(
        todayKoreanFood: 0,
        todayJapaneseFood: 0,
        todayChineseFood: 0,
        todayWesternFood: 0,
        todaySoutheastAsianFood: 0,
        todayElseFood: 0,
        todayMeat: 0,
        todaySeafood: 0,
        todayCarbohydrate: 0,
        todayVegetable: 0,
        redFood: 0,
        notRedFood: 0,
        todayRice: 0,
        todayBread: 0,
        todayNoodle: 0,
        todayHeavy: 0,
        todayLight: 0,
        todaySoup: 0,
        todayNoSoup: 0,
        notToday: ""
    )
    
    
    
    
    let lineImage1 : UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "yellowLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage2 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage3 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage4 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    
    let lineImage5 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    
    let lineImage6 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    let lineImage7 : UIImageView = {
        let lineImage = UIImageView()
        
    
        lineImage.image = UIImage(named: "grayLine")
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.contentMode = .scaleAspectFit
        return lineImage
    }()
    
    
    let titleLabel1 : UILabel = {
        let label = UILabel()
        label.text = "어제 먹었던 음식"
        label.font = UIFont(name: "Pretendard-Bold", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel2 : UILabel = {
        let label = UILabel()
        label.text = "을"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel3 : UILabel = {
        let label = UILabel()
        label.text = "작성해주세요!"
        label.font = UIFont(name: "Pretendard-Light", size: 26)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel4 : UILabel = {
        let label = UILabel()
        label.text = "데일리 입맛은 스크럼 페이지에서 다시 수정할 수 있어요!"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.textColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    let nextButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        
        
        // 내부 여백 설정
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0)
        
        config.title = "다음"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "Pretendard-SemiBold", size: 17)
            outgoing.foregroundColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
            return outgoing
        }
    
        var button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.isEnabled = false
        
        return button
        
    }()
    
    
    
    
    var searchTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    

    
    
    
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(moveToNext), for: .touchUpInside)
        setUI()
        searchBar.delegate = self

        setupSearchBar()
        setupBackButton()
        loadFoodList()
                  updateNextButtonState()
        
        print("model1 : \(dailyScrumModel)")
        print("uid1 : \(uid)" )
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "foodCell")
        
//
       
    }
    
    func getHangulComponents(of string: String) -> String {
           let initialConsonants = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ"
           let medialVowels = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ"
           let finalConsonants = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

           let unicodeScalars = string.unicodeScalars
           var components = ""
           
           for scalar in unicodeScalars {
               let value = scalar.value
               if value >= 0xAC00 && value <= 0xD7A3 { // 한글 음절 범위
                   let index = Int(value - 0xAC00)
                   let initialIndex = index / 28 / 21
                   let medialIndex = (index / 28) % 21
                   let finalIndex = index % 28
                   let initialConsonant = initialConsonants[initialConsonants.index(initialConsonants.startIndex, offsetBy: initialIndex)]
                   let medialVowel = medialVowels[medialVowels.index(medialVowels.startIndex, offsetBy: medialIndex)]
                   let finalConsonant = finalConsonants[finalIndex]
                   
                   components.append(initialConsonant)
                   components.append(medialVowel)
                   if !finalConsonant.isEmpty {
                       components.append(finalConsonant)
                   }
               } else {
                   components.append(Character(scalar))
               }
           }
           return components
       }
    
    
    
    
    func filterFood(searchText: String) {
        
        
        if searchText.isEmpty {
            filteredFood = []
        }else {
            filteredFood = food.filter { foodItem in
                if foodItem.hasPrefix(searchText) {
                    return true
                }
                let hangulComponents = getHangulComponents(of: foodItem)
                return hangulComponents.hasPrefix(searchText)
            }
        }
    }
    
    

      
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        filterFood(searchText: searchText)
        searchTableView.reloadData()
    }

    
    
    
    
    func setupSearchBar() {
        searchBar.placeholder = "메뉴명을 입력해주세요."
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.font = UIFont(name: "Pretendard-Regular", size: 17)
        // 기본 서치바 스타일 제거
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .clear
        
        // 텍스트 색상 설정
        let textColor = UIColor.black
        searchBar.searchTextField.textColor = textColor
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "메뉴명을 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        // 검색 아이콘 색상 설정
        if let searchIconView = searchBar.searchTextField.leftView as? UIImageView {
            searchIconView.tintColor = .gray
        }
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        
       
        
        
        
        
        // 왼쪽 뷰 제거 (기본 돋보기 아이콘 제거)
            searchBar.searchTextField.leftView = nil
            searchBar.searchTextField.leftViewMode = .never
            searchBar.searchTextField.clearButtonMode = .never
        
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: searchBar.frame.height))
            searchBar.searchTextField.leftView = paddingView
            searchBar.searchTextField.leftViewMode = .always
        
            // 오른쪽에 돋보기 아이콘 추가
            let searchIcon = UIImageView(image: UIImage(named: "glass"))
            searchIcon.tintColor = .gray
            searchIcon.contentMode = .center
        
        
        
        
        let iconSize = CGSize(width: 14, height: 14)
        searchIcon.frame = CGRect(origin: .zero, size: iconSize)
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.clipsToBounds = true


        view.addSubview(searchIcon)
        view.addSubview(paddingView)
        
        let grayLine = UIView()
        grayLine.backgroundColor = #colorLiteral(red: 0.8275603652, green: 0.827560246, blue: 0.8275603652, alpha: 1)
        view.addSubview(grayLine)
        
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.searchTextField.textAlignment = .left

        
        NSLayoutConstraint.activate([
                grayLine.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                grayLine.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant:  10),
                grayLine.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
                grayLine.heightAnchor.constraint(equalToConstant: 1), // 줄의 두께
                
                searchIcon.bottomAnchor.constraint(equalTo: grayLine.topAnchor , constant:  -7),
                searchIcon.trailingAnchor.constraint(equalTo: grayLine.trailingAnchor),
                searchIcon.widthAnchor.constraint(equalToConstant: 24),
                searchIcon.heightAnchor.constraint(equalToConstant: 24),
                
               
            ])
        

        
    }
    
    
    
    
    
    
    // 빈화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func updateNextButtonState() {
        if !searchText.isEmpty {
                nextButton.isEnabled = true
                nextButton.configuration?.background.backgroundColor = #colorLiteral(red: 1, green: 0.5921568627, blue: 0.1019607843, alpha: 1) // 활성화 색상
                nextButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.foregroundColor = UIColor.white
                    return outgoing
                }
            } else {
                nextButton.isEnabled = false
                nextButton.configuration?.background.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1) // 비활성화 색상
                nextButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.foregroundColor = UIColor.gray
                    return outgoing
                }
            }
        }
    
    
    @objc func moveToNext(){
        if searchText != "" {
            let preferVC = PreferViewController2()
            
            dailyScrumModel.notToday = searchText
            
            
            preferVC.dailyScrumModel = self.dailyScrumModel
            preferVC.uid = self.uid  // uid 전달
            preferVC.name = self.name  // name 전달
            let transition = CATransition()
            transition.duration = 0.4
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // 현재 window에 전환 애니메이션 적용
            view.window?.layer.add(transition, forKey: kCATransition)
            preferVC.modalPresentationStyle = .fullScreen  // 전체 화면으로 설정
            present(preferVC, animated: false, completion: nil)
        }
    }
    
    
    func setUI(){
        view.addSubview(lineImage1)
        view.addSubview(lineImage2)
        view.addSubview(lineImage3)
        view.addSubview(lineImage4)
        view.addSubview(lineImage5)
        view.addSubview(lineImage6)
        view.addSubview(lineImage7)
        
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(titleLabel3)
        view.addSubview(titleLabel4)
        view.addSubview(nextButton)
        view.addSubview(searchBar)
        view.addSubview(searchTableView)
                
        
        NSLayoutConstraint.activate([
            lineImage1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 33),
            lineImage1.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage2.leadingAnchor.constraint(equalTo: lineImage1.trailingAnchor , constant: 14),
            lineImage2.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage3.leadingAnchor.constraint(equalTo: lineImage2.trailingAnchor , constant: 14),
            lineImage3.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage4.leadingAnchor.constraint(equalTo: lineImage3.trailingAnchor , constant: 14),
            lineImage4.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage5.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage5.leadingAnchor.constraint(equalTo: lineImage4.trailingAnchor , constant: 14),
            lineImage5.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage6.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage6.leadingAnchor.constraint(equalTo: lineImage5.trailingAnchor , constant: 14),
            lineImage6.widthAnchor.constraint(equalToConstant: 35),
            
            lineImage7.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 57.4),
            lineImage7.leadingAnchor.constraint(equalTo: lineImage6.trailingAnchor , constant: 14),
            lineImage7.widthAnchor.constraint(equalToConstant: 35),
            
            

            titleLabel1.topAnchor.constraint(equalTo: lineImage1.topAnchor , constant: 38),
            titleLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 32),
            
            titleLabel2.topAnchor.constraint(equalTo: lineImage1.topAnchor , constant: 38),
            titleLabel2.leadingAnchor.constraint(equalTo: titleLabel1.trailingAnchor , constant: 0),
            
            titleLabel3.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor , constant: 3),
            titleLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            titleLabel4.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor , constant: 499),
            titleLabel4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 43),
            titleLabel4.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -43),
            
            nextButton.topAnchor.constraint(equalTo: titleLabel4.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            
            searchBar.topAnchor.constraint(equalTo: titleLabel3.bottomAnchor, constant: 63),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
            
            searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor , constant: 20 ),
            searchTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            searchTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            searchTableView.bottomAnchor.constraint(equalTo: titleLabel4.topAnchor, constant: -30),
            
            
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
    
    
    @objc func dismissVC() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    

    
}



//MARK: - foodlist check
extension PreferViewController1 {
    
    // GET
   func foodListCheck(completion: @escaping ([FoodListModel]?, Error?) -> Void) {
        guard let url = URL(string: "https://mumuk.store/food/list") else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let foodList = try JSONDecoder().decode([FoodListModel].self, from: data)
                completion(foodList, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    
    // 음식 목록 GET 해오기
    func loadFoodList() {
            foodListCheck { [weak self] foodList, error in
                DispatchQueue.main.async {
                    guard let self = self else { return }

                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    if let foodList = foodList {
                        self.food = foodList.compactMap { $0.foodName }
//                        print("Food list loaded: \(self.food)")
                        

                    } else {
                        print("No food list received")
                    }
                }
            }
        }
   
    

    
    
}

extension PreferViewController1: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredFood.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? SearchTableViewCell else {
              return UITableViewCell()
          }
          
          cell.textLabel?.text = filteredFood[indexPath.row]
          cell.backgroundColor = .white
          return cell
      }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFood.count
    }
  
    
    
    
    // cell 간격 조정
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 15
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          let selectedFood = filteredFood[indexPath.row]
          print("Selected Food: \(selectedFood)")
          
          
          searchText = selectedFood
          searchBar.text = selectedFood
          
          filterFood(searchText: selectedFood)
         
          searchTableView.reloadData()
          updateNextButtonState()
          
      }
}
