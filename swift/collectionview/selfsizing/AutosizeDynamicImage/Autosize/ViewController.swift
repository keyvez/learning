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
    let cell = Cell(frame: CGRectMake(0, 0, cellWidth, 0))
    layout.estimatedItemSize = cell.estimatedSize()

    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.registerClass(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = UIColor.whiteColor()

    view.addSubview(collectionView)
  }

  func addConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
        collectionView.topAnchor.constraintEqualToAnchor(view.topAnchor),
        collectionView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
        collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
        collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
    ]

    constraints.forEach { $0.active = true }
  }
}

//MARK:
//MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

  func collectionView(collectionView: UICollectionView,
                      cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
        forIndexPath: indexPath) as! Cell

    if self.fetched![indexPath.item] {
      self.setImage(cell, indexPath: indexPath)
    } else {
      let height = self.heights![indexPath.item]
      cell.setSize(CGSizeMake(collectionView.bounds.width, height))
      let randomTime = 1 / (Double) (arc4random_uniform(20) + 1)
      let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(randomTime * Double(NSEC_PER_SEC)))
      dispatch_after(delayTime, dispatch_get_main_queue()) {
        self.setImage(cell, indexPath: indexPath)
        self.fetched![indexPath.item] = true
      }
    }

    return cell
  }

  func setImage(cell: Cell, indexPath: NSIndexPath) {
    let height = heights![indexPath.item]
    let image = UIImage.imageWithColor(colors![indexPath.item], size: CGSizeMake(375.0, height))
    cell.setModel(indexPath.item, image: image)
  }
}
