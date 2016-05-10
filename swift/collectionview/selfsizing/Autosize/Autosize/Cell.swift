import Foundation

import UIKit


class Cell: UICollectionViewCell {
  lazy private var label:UILabel = UILabel()
  lazy private var subLabel: UILabel! = UILabel()
  lazy private var infoLabel: UILabel! = UILabel()
  lazy private var separator: UIView! = UIView()
  var showSeparator: Bool {
    get {
      return self.showSeparator
    }
    set(newShowSeparator) {
      separator.hidden = !newShowSeparator
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    separator = UIView()
    separator.hidden = true
    separator.userInteractionEnabled = false
    separator.backgroundColor = UIColor(red:0.885, green:0.885, blue:0.885, alpha:1.00)

    label.textColor = UIColor(red:0.400, green:0.400, blue:0.400, alpha:1.00)
    label.numberOfLines = 0
    label.textAlignment = .Left
    label.lineBreakMode = .ByWordWrapping

    subLabel = UILabel()
    subLabel.font = UIFont.boldSystemFontOfSize(16)
    subLabel.textColor = UIColor(red:0.400, green:0.400, blue:0.400, alpha:1.00)
    subLabel.numberOfLines = 0

    infoLabel = UILabel()
    infoLabel.textAlignment = .Center

    contentView.addSubview(separator)
    contentView.addSubview(label)
    contentView.addSubview(subLabel)
    contentView.addSubview(infoLabel)

    addConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func estimatedSize() -> CGSize {
    let height = floor(label.font.lineHeight) + // title title
        floor(subLabel.font.lineHeight) + // start time title
        1 + // separator
        7 + // margin between separator and title
        8 // margin between title and time
    return CGSizeMake(frame.width, height)
  }

  func addConstraints() {
    [contentView, separator, label, subLabel, infoLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    contentView.setContentHuggingPriority(1, forAxis: .Horizontal)
    contentView.setContentCompressionResistancePriority(751, forAxis: .Horizontal)

    label.setContentHuggingPriority(1, forAxis: .Horizontal)
    label.setContentCompressionResistancePriority(751, forAxis: .Horizontal)

    separator.setContentHuggingPriority(751, forAxis: .Vertical)

    subLabel.setContentHuggingPriority(1, forAxis: .Vertical)
    subLabel.setContentHuggingPriority(49, forAxis: .Horizontal)
    subLabel.setContentCompressionResistancePriority(751, forAxis: .Vertical)

    infoLabel.setContentHuggingPriority(251, forAxis: .Vertical)
    infoLabel.setContentHuggingPriority(251, forAxis: .Horizontal)
    infoLabel.setContentCompressionResistancePriority(751, forAxis: .Horizontal)

    let view = contentView

    let constraints = [
        view.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
        view.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
        view.topAnchor.constraintEqualToAnchor(topAnchor),
        view.bottomAnchor.constraintEqualToAnchor(bottomAnchor),

        separator.topAnchor.constraintEqualToAnchor(view.topAnchor),
        separator.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
        separator.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
        separator.heightAnchor.constraintEqualToConstant(1),

        label.topAnchor.constraintEqualToAnchor(separator.bottomAnchor, constant: 7),
        label.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
        label.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),

        subLabel.topAnchor.constraintEqualToAnchor(label.bottomAnchor, constant: 8.0),

        subLabel.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
        subLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),

        subLabel.trailingAnchor.constraintEqualToAnchor(infoLabel.leadingAnchor),

        infoLabel.centerYAnchor.constraintEqualToAnchor(subLabel.centerYAnchor),
        infoLabel.leadingAnchor.constraintEqualToAnchor(subLabel.trailingAnchor),
        infoLabel.trailingAnchor.constraintEqualToAnchor(label.trailingAnchor),
    ]

    constraints.forEach { $0.active = true }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    label.text = ""
    subLabel.text = ""
    infoLabel.text = ""
  }

  func setModel(index: Int, name: String, description: String) {
    label.text = name
    subLabel.text = description
    infoLabel.text = String(index+1)

    showSeparator = index > 0
  }

  @available(iOS 8.0, *) override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

    let v = super.preferredLayoutAttributesFittingAttributes(layoutAttributes)
    print(v)

    return v
  }

}

