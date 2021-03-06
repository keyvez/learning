import UIKit
import QuartzCore

class ViewController: UIViewController {

  var collectionView: UICollectionView!
  let reuseIdentifier = "cell"
  var toolbar: UIToolbar!
  var didAddConstraints: Bool = false
  var colors:[UIColor]?
  var sizes:[CGSize]?
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
    layout.estimatedItemSize = Cell.estimatedSize(forWidth: cellWidth)

    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = UIColor.white

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
      sizes = [CGSize]()
      fetched = [Bool]()
      for _ in 1...10 {
        colors!.append(UIColor.randomColor())
        sizes!.append(
            CGSize(width: collectionView.bounds.width,
                height: (CGFloat) (arc4random_uniform(700) + 1)))
        fetched!.append(false)
      }
    }

    return colors!.count
  }

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
        for: indexPath) as! Cell

    if self.fetched![(indexPath as NSIndexPath).item] {
      self.setImage(cell, indexPath: indexPath)
    } else {
      let height = self.sizes![(indexPath as NSIndexPath).item]
      cell.setSize(height)
      let randomTime = 1 / (Double) (arc4random_uniform(20) + 1)
      let delayTime = DispatchTime.now() + Double(Int64(randomTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
      DispatchQueue.main.asyncAfter(deadline: delayTime) {
        self.setImage(cell, indexPath: indexPath)
        self.fetched![(indexPath as NSIndexPath).item] = true
      }
    }

    return cell
  }

  func setImage(_ cell: Cell, indexPath: IndexPath) {
    let height = sizes![(indexPath as NSIndexPath).item]
    let image = UIImage.imageWithColor(color: colors![(indexPath as NSIndexPath).item], size: height)
    cell.setModel((indexPath as NSIndexPath).item, image: image, height: height)
  }
}
