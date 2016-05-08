import UIKit
import QuartzCore

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    let reuseIdentifier = "cell"
    var words: [String]?
    var toolbar: UIToolbar!
    var didAddConstraints: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Random Sentences"

        makeCollectionView()

        addConstraints()

        makeData()

        self.collectionView.reloadData()
    }

    func makeData() {
        words = [String]()
        for _ in 1...1000 {
            let string = randomStringWithSentenceLength(100)
            words!.append(string)
        }
    }

    func makeCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let cellWidth = view.bounds.width
        layout.estimatedItemSize = CGSize(width:cellWidth, height:10.0)

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
        return words?.count ?? 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! Cell

        let word = words![indexPath.item]
        let anotherWord = randomStringWithSentenceLength(10)
        cell.setModel(indexPath.item, name: word, description: anotherWord)

        return cell
    }
}
