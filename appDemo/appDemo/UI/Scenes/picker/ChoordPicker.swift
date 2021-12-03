//
//  ChoordPicker.swift
//  appDemo
//
//  Created by Damien on 30/11/2021.
//



import UIKit


struct ChoordPickerAttribute {
    var font: UIFont? = UIFont(name: "Helvetica", size: 40)
    var itemSize: Int = 40
    var activeDistance: CGFloat = 100
}

protocol ChoordPickerDelegate: AnyObject {
    func choordPickerNumberIfItems(picker:ChoordPicker) -> Int
    func choordPickerItemName(picker:ChoordPicker, index: Int ) -> String?
    func choordPickerDidSelect(picker:ChoordPicker, index: Int )
}


class ChoordPicker: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    static let cellIdentifier = "cell"
    @IBInspectable var layout: ChoordFlowLayout?
    weak var pickerDelegate: ChoordPickerDelegate?
    var selectedIndex: IndexPath = IndexPath(row: -1, section: 0)
    var presentedIndex: IndexPath = IndexPath(row: -1, section: 0)
    var attribute: ChoordPickerAttribute?

    init( attribute: ChoordPickerAttribute) {
        let layout = ChoordFlowLayout(attribute: attribute)
        self.attribute = attribute
        super.init(frame: .zero, collectionViewLayout: layout)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


  private  func initialize() {
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false
        self.register(ChoordPickerCell.self, forCellWithReuseIdentifier: ChoordPicker.cellIdentifier)
    }



    override func reloadData() {
        self.layout?.invalidateLayout()
        super.reloadData()
    }

    func scrollsToTop() {
        if self.visibleCells.count > 0 {
        self.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        self.pickerDelegate?.choordPickerNumberIfItems(picker: self) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChoordPicker.cellIdentifier,
            for: indexPath) as! ChoordPickerCell


        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = self.attribute?.font
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.pickerDelegate?.choordPickerItemName(picker: self, index: indexPath.row)
        cell.addViews(label)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       select()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        select()
    }

    private func select() {
        if selectedIndex.row != presentedIndex.row {
            presentedIndex = selectedIndex
            self.pickerDelegate?.choordPickerDidSelect(picker: self, index: presentedIndex.row)
        }
    }
}

 fileprivate class ChoordPickerCell: UICollectionViewCell {


    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func addViews(_ view: UIView){
        backgroundColor = .clear
        addSubview(view)
        view.bindFrameToSuperviewBounds()
    }
}

extension UIView {
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
}

class ChoordFlowLayout: UICollectionViewFlowLayout {
    private  var activeDistance: CGFloat = 100
    private var zoomFactor: CGFloat = 2

    init(attribute: ChoordPickerAttribute) {
        super.init()
        scrollDirection = .horizontal
        self.activeDistance = attribute.activeDistance
        self.itemSize =  CGSize(width: attribute.itemSize, height: attribute.itemSize)
        minimumLineSpacing =  0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        guard let collectionView = collectionView else { fatalError() }
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.right - collectionView.adjustedContentInset.left - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)

        super.prepare()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        // Make the cells be zoomed when they reach the center of the screen
        for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
            let distance = abs(visibleRect.midX - attributes.center.x)
            let distanceRatio =  distance / (visibleRect.size.width / 2)
            let transformRatio = 1 - ( 3 * distanceRatio / 4)
            attributes.alpha = transformRatio
            attributes.transform3D = CATransform3DMakeScale(transformRatio, transformRatio, 1)
            attributes.zIndex = Int(transformRatio.rounded())
            if let picker =  self.collectionView as? ChoordPicker {
                if distance < activeDistance  &&  picker.selectedIndex.row != attributes.indexPath.row {
                    picker.selectedIndex = attributes.indexPath
                }
            }
        }
            return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Add some snapping behaviour so that the zoomed cell is always centered
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Invalidate layout so that every cell get a chance to be zoomed when it reaches the center of the screen
        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}
