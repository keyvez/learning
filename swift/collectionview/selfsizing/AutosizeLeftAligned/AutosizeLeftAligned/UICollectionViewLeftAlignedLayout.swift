import UIKit

class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let originalAttributes = super.layoutAttributesForElements(in: rect)
    var updatedAttributes = originalAttributes!
    for attributes: UICollectionViewLayoutAttributes in originalAttributes! {
      if !(attributes.representedElementKind != nil) {
        let index = updatedAttributes.index(of: attributes)
        updatedAttributes[index!] = self.layoutAttributesForItem(at: attributes.indexPath)!
      }
    }
    return updatedAttributes
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)!
    let sectionInset = self.evaluatedSectionInsetForItem(at: indexPath.section)
    let isFirstItemInSection = indexPath.item == 0
    let layoutWidth = (self.collectionView?.frame)!.width - sectionInset.left - sectionInset.right
    if isFirstItemInSection {
      currentItemAttributes.leftAlignFrameWithSectionInset(sectionInset)
      return currentItemAttributes
    }
    let previousIndexPath = NSIndexPath(item: indexPath.item - 1, section: indexPath.section)
    let previousFrame = self.layoutAttributesForItem(at: previousIndexPath as IndexPath)?.frame
    let previousFrameRightPoint = (previousFrame?.origin.x)! + (previousFrame?.size.width)!
    let currentFrame = (currentItemAttributes as UICollectionViewLayoutAttributes).frame
    let stretchedCurrentFrame =
        CGRect(x: sectionInset.left,
            y: currentFrame.origin.y,
            width: layoutWidth,
            height: currentFrame.size.height)
    let isFirstItemInRow = !previousFrame!.intersects(stretchedCurrentFrame)
    if isFirstItemInRow {
      currentItemAttributes.leftAlignFrameWithSectionInset(sectionInset)
      return currentItemAttributes
    }
    var frame = currentItemAttributes.frame
    frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacingForSection(at: indexPath.section)
    currentItemAttributes.frame = frame

    return currentItemAttributes
  }

  func evaluatedMinimumInteritemSpacingForSection(at sectionIndex: Int) -> CGFloat {
    let selector = #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))
    if self.collectionView?.delegate?.responds(to: selector) == true {
      let delegate = self.collectionView?.delegate as! UICollectionViewDelegateLeftAlignedLayout
      return delegate.collectionView!(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: sectionIndex)
    } else {
      return self.minimumInteritemSpacing
    }
  }

  func evaluatedSectionInsetForItem(at index: Int) -> UIEdgeInsets {
    let selector = #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))
    if self.collectionView?.delegate?.responds(to: selector) == true {
      let delegate = self.collectionView?.delegate as!  UICollectionViewDelegateLeftAlignedLayout
      return delegate.collectionView!(self.collectionView!, layout: self, insetForSectionAt: index)
    } else {
      return self.sectionInset
    }
  }
}

protocol UICollectionViewDelegateLeftAlignedLayout: UICollectionViewDelegateFlowLayout {
}

extension UICollectionViewLayoutAttributes {
  func leftAlignFrameWithSectionInset(_ sectionInset: UIEdgeInsets) {
    var frame = self.frame
    frame.origin.x = sectionInset.left
    self.frame = frame
  }
}
