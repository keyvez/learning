import UIKit
import QuartzCore

class ViewController: UIViewController {

  var collectionView: UICollectionView!
  let reuseIdentifier = "cell"
  var toolbar: UIToolbar!
  var didAddConstraints: Bool = false
  var colors:[UIColor]?
  var heights:[CGFloat]?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Random Images"
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
      for i in 1...100 {
        colors!.append(UIColor.randomColor())
        heights!.append((CGFloat) (arc4random_uniform(600) + 1))
      }
    }

    return colors!.count
  }

  func collectionView(collectionView: UICollectionView,
                      cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
        forIndexPath: indexPath) as! Cell

    let height = heights![indexPath.item]
    let image = UIImage.imageWithColor(colors![indexPath.item], size: CGSizeMake(375.0, height))
    cell.setModel(indexPath.item, image: image)

    return cell
  }
}
