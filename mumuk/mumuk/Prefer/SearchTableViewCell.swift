import UIKit

class SearchTableViewCell: UITableViewCell {
    let foodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Pretendard-Regular", size: 15)
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "foodCell")
        contentView.addSubview(foodLabel)
        
        
        NSLayoutConstraint.activate([
            foodLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ,constant: 8 ),
            foodLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 16),
            foodLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
   
}
