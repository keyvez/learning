import Foundation

import UIKit


class Cell: UICollectionViewCell {
  lazy var label:UILabel = UILabel()
  lazy var subLabel: UILabel! = UILabel()
  lazy var infoLabel: UILabel! = UILabel()
  lazy var separator: UIView! = UIView()

  var showSeparator: Bool {
    get {
      return self.showSeparator
    }
    set(newShowSeparator) {
      separator.isHidden = !newShowSeparator
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    label.textColor = UIColor(red:0.400, green:0.400, blue:0.400, alpha:1.00)
    label.textAlignment = .left

    contentView.backgroundColor = UIColor(red: 0.926, green: 0.936, blue: 0.936, alpha: 1.0)

    contentView.addSubview(separator)
    contentView.addSubview(label)

    addConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  static func estimatedSize(forWidth width: CGFloat) -> CGSize {
    return CGSize(width: 50, height: 32)
  }

  func addConstraints() {
    [label].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let view = contentView

    let constraints = [
        label.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 7),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ]

    constraints.forEach { $0.isActive = true }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    label.text = ""
  }

  func setModel(_ index: Int, name: String) {
    label.text = name
    label.sizeToFit()
  }

}

