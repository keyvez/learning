import Foundation

import UIKit


class Cell: UICollectionViewCell {
  lazy private var imageView:UIImageView = UIImageView()
  lazy private var label:UILabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    label.textColor = UIColor.whiteColor()
    label.numberOfLines = 0
    label.textAlignment = .Center

    contentView.backgroundColor = UIColor.brownColor()

    contentView.addSubview(imageView)
    contentView.addSubview(label)

    addConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func estimatedSize() -> CGSize {
    return CGSizeMake(frame.width, 100.0)
  }

  func addConstraints() {
    [contentView, label, imageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let view = contentView

    let constraints = [
        view.leadingAnchor.constraintEqualToAnchor(leadingAnchor),
        view.trailingAnchor.constraintEqualToAnchor(trailingAnchor),
        view.topAnchor.constraintEqualToAnchor(topAnchor),
        view.bottomAnchor.constraintEqualToAnchor(bottomAnchor),

        imageView.topAnchor.constraintEqualToAnchor(view.topAnchor),
        imageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
        imageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
        imageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),

        label.topAnchor.constraintEqualToAnchor(imageView.topAnchor),
        label.leadingAnchor.constraintEqualToAnchor(imageView.leadingAnchor),
        label.trailingAnchor.constraintEqualToAnchor(imageView.trailingAnchor),
        label.bottomAnchor.constraintEqualToAnchor(imageView.bottomAnchor),
    ]

    constraints.forEach { $0.active = true }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    label.text = ""
  }

  func setModel(index: Int, image: UIImage) {
    imageView.image = image
    imageView.backgroundColor = UIColor.grayColor()
    label.text = String(index)
  }

  func setSize(size: CGSize) {
    imageView.image = UIImage.imageWithColor(UIColor.clearColor(), size: size)
  }

}

