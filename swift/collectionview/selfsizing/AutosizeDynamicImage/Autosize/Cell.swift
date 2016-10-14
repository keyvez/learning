import Foundation

import UIKit


class Cell: UICollectionViewCell {
  lazy var imageView:UIImageView = UIImageView()
  lazy var label:UILabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    label.textColor = UIColor.white
    label.numberOfLines = 0
    label.textAlignment = .center

    contentView.backgroundColor = UIColor.brown

    contentView.addSubview(imageView)
    contentView.addSubview(label)

    addConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func estimatedSize(forWidth width: CGFloat) -> CGSize {
    return CGSize(width: width, height: 100.0)
  }

  func addConstraints() {
    [contentView, label, imageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let view = contentView

    let constraints = [
        view.leadingAnchor.constraint(equalTo: leadingAnchor),
        view.trailingAnchor.constraint(equalTo: trailingAnchor),
        view.topAnchor.constraint(equalTo: topAnchor),
        view.bottomAnchor.constraint(equalTo: bottomAnchor),

        imageView.topAnchor.constraint(equalTo: view.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        label.topAnchor.constraint(equalTo: imageView.topAnchor),
        label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
    ]

    constraints.forEach { $0.isActive = true }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    label.text = ""
  }

  func setModel(_ index: Int, image: UIImage) {
    imageView.image = image
    imageView.backgroundColor = UIColor.gray
    label.text = String(index)
  }

  func setSize(_ size: CGSize) {
    imageView.image = UIImage.imageWithColor(UIColor.clear, size: size)
  }

}

