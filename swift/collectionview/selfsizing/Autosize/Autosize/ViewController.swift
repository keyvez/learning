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
        var cell = Cell(frame: CGRectMake(0, 0, cellWidth, 0))
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
        return words?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell

        let word = words![(indexPath as NSIndexPath).item]
        let anotherWord = randomStringWithSentenceLength(10)
        cell.setModel((indexPath as NSIndexPath).item, name: word, description: anotherWord)

        return cell
    }
}
