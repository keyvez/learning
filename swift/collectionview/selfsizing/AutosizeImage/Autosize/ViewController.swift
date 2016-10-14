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
    let cell = Cell(frame: CGRect(x: 0, y: 0, width: cellWidth, height: 0))
    layout.estimatedItemSize = cell.estimatedSize()

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

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
        for: indexPath) as! Cell

    let height = heights![(indexPath as NSIndexPath).item]
    let image = UIImage.imageWithColor(colors![(indexPath as NSIndexPath).item], size: CGSize(width: 375.0, height: height))
    cell.setModel((indexPath as NSIndexPath).item, image: image)

    return cell
  }
}
