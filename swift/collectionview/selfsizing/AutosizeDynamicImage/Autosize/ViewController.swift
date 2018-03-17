import UIKit
import QuartzCore

class ViewController: UIViewController {

  var collectionView: UICollectionView!
  let reuseIdentifier = "cell"
  var toolbar: UIToolbar!
  var didAddConstraints: Bool = false
  var colors:[UIColor]?
  var heights:[CGFloat]?
  var fetched:[Bool]?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Dynamic Images"
    makeCollectionView()
    addConstraints()
    self.collectionView.reloadData()
  }

  func makeCollectionView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    let cellWidth = view.bounds.width
    let cell = Cell(frame: CGRect(x: 0, y: 0, width: cellWidth, height: 0))
    layout.estimatedItemSize = cell.estimatedSize()

    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white

    view.addSubview(collectionView)
  }

  func addConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
        collectionView.topAnchor.constraint(equalTo: view.topAnchor),
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ]

    constraints.forEach { $0.isActive = true }
  }
}

//MARK:
//MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if colors == nil {
      colors = [UIColor]()
      heights = [CGFloat]()
      fetched = [Bool]()
      for _ in 1...10 {
        colors!.append(UIColor.randomColor())
        heights!.append((CGFloat) (arc4random_uniform(700) + 1))
        fetched!.append(false)
      }
    }

    return colors!.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
        for: indexPath as IndexPath) as! Cell

    if self.fetched![indexPath.item] {
      self.setImage(cell: cell, indexPath: indexPath)
    } else {
      let height = self.heights![indexPath.item]
      cell.setSize(size: CGSize(width: collectionView.bounds.width, height: height))
      let randomTime = 1 / Double(arc4random_uniform(20)) + 1
      let delayTime:DispatchTime = .now() + .seconds(Int(randomTime))
      DispatchQueue.main.asyncAfter(deadline: delayTime) {
        self.setImage(cell: cell, indexPath: indexPath)
        self.fetched![indexPath.item] = true
      }
    }

    return cell
  }

  func setImage(cell: Cell, indexPath: IndexPath) {
    let height = heights![indexPath.item]
    let image = UIImage.imageWithColor(color: colors![indexPath.item], size: CGSize(width: 375.0, height: height))
    cell.setModel(index: indexPath.item, image: image)
  }
}
