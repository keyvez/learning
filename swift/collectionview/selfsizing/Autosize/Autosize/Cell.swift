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

    separator = UIView()
    separator.isHidden = true
    separator.isUserInteractionEnabled = false
    separator.backgroundColor = UIColor(red:0.885, green:0.885, blue:0.885, alpha:1.00)

    label.textColor = UIColor(red:0.400, green:0.400, blue:0.400, alpha:1.00)
    label.numberOfLines = 0
    label.textAlignment = .left
    label.lineBreakMode = .byWordWrapping

    let infoLabelMaxWidth = CGFloat(44)

    subLabel = UILabel()
    subLabel.font = UIFont.boldSystemFont(ofSize: 16)
    subLabel.textColor = UIColor(red:0.400, green:0.400, blue:0.400, alpha:1.00)
    subLabel.numberOfLines = 0
    subLabel.preferredMaxLayoutWidth = frame.width - infoLabelMaxWidth

    infoLabel = UILabel()
    infoLabel.textAlignment = .center

    contentView.addSubview(separator)
    contentView.addSubview(label)
    contentView.addSubview(subLabel)
    contentView.addSubview(infoLabel)

    addConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func estimatedSize(forWidth width: CGFloat) -> CGSize {
    return CGSize(width: width, height: 100)
  }

  func addConstraints() {
    [contentView, separator, label, subLabel, infoLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    contentView.setContentHuggingPriority(1, for: .horizontal)
    contentView.setContentCompressionResistancePriority(751, for: .horizontal)

    label.setContentHuggingPriority(1, for: .horizontal)
    label.setContentCompressionResistancePriority(751, for: .horizontal)

    separator.setContentHuggingPriority(751, for: .vertical)

    subLabel.setContentHuggingPriority(49, for: .horizontal)

    infoLabel.setContentHuggingPriority(251, for: .vertical)
    infoLabel.setContentHuggingPriority(251, for: .horizontal)
    infoLabel.setContentCompressionResistancePriority(750, for: .horizontal)

    let view = contentView

    let constraints = [
        view.leadingAnchor.constraint(equalTo: leadingAnchor),
        view.trailingAnchor.constraint(equalTo: trailingAnchor),
        view.topAnchor.constraint(equalTo: topAnchor),
        view.bottomAnchor.constraint(equalTo: bottomAnchor),

        separator.topAnchor.constraint(equalTo: view.topAnchor),
        separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        separator.heightAnchor.constraint(equalToConstant: 1),

        label.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 7),
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        subLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8.0),

        subLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),

        subLabel.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor),

        infoLabel.centerYAnchor.constraint(equalTo: subLabel.centerYAnchor),
        infoLabel.leadingAnchor.constraint(equalTo: subLabel.trailingAnchor),
        infoLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
    ]

    constraints.forEach { $0.isActive = true }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    label.text = ""
    subLabel.text = ""
    infoLabel.text = ""
  }

  func setModel(_ index: Int, name: String, description: String) {
    label.text = name
    subLabel.text = description
    infoLabel.text = String(index+1)

    showSeparator = index > 0
  }

}

