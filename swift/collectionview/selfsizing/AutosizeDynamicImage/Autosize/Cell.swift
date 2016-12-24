import Foundation

import UIKit


class Cell: UICollectionViewCell {
  lazy var imageView:UIImageView = UIImageView()
  lazy var label:UILabel = UILabel()
  lazy var heightLabel:UILabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    label.textColor = UIColor.white
    label.numberOfLines = 0
    label.textAlignment = .center

    heightLabel.textColor = UIColor.white
    heightLabel.numberOfLines = 0
    heightLabel.textAlignment = .center

    contentView.backgroundColor = UIColor.brown

    contentView.addSubview(imageView)
    contentView.addSubview(heightLabel)
    contentView.addSubview(label)

    addConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  static func estimatedSize(forWidth width: CGFloat) -> CGSize {
    return CGSize(width: width, height: 100.0)
  }

  func addConstraints() {
    [label, imageView, heightLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let view = contentView

    let constraints = [
        imageView.topAnchor.constraint(equalTo: view.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        heightLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
        heightLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        heightLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        heightLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

        label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
        label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ]

    constraints.forEach { $0.isActive = true }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    label.text = ""
  }

  func setModel(_ index: Int, image: UIImage, height: CGSize) {
    imageView.image = image
    imageView.backgroundColor = UIColor.gray
    label.text = String(index)
    heightLabel.text = "\(UInt32(height.width)), \(UInt32(height.height))"
  }

  func setSize(_ size: CGSize) {
    imageView.image = UIImage.imageWithColor(UIColor.clear, size: size)
  }

}

