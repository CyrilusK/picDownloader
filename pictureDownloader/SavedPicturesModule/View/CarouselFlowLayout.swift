//
//  CarouselFlowLayout.swift
//  pictureDownloader
//
//  Created by Cyril Kardash on 29.07.2024.
//

import UIKit

final class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    private let activeDistance: CGFloat = 200
    private let zoomFactor: CGFloat = 0.3

    override init() {
        super.init()
        scrollDirection = .horizontal
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { fatalError() }
        
        let verticalInsets = (collectionView.frame.height - collectionView.adjustedContentInset.bottom - collectionView.adjustedContentInset.top - itemSize.height) / 2
        let horizontalInsets = (collectionView.frame.width - collectionView.adjustedContentInset.left - collectionView.adjustedContentInset.right - itemSize.width) / 2
        sectionInset = UIEdgeInsets(top: verticalInsets - collectionView.safeAreaInsets.bottom, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let rectAttributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes } ?? []
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)
        let visibleAttributes = rectAttributes.filter { $0.frame.intersects(visibleRect) }

        func adjustXPosition(_ toProcess: [UICollectionViewLayoutAttributes], direction: CGFloat, zoom: Bool = false) {
            var dx: CGFloat = 0

            for attributes in toProcess {
                let distance = visibleRect.midX - attributes.center.x
                attributes.frame.origin.x += dx

                if distance.magnitude < activeDistance {
                    let normalizedDistance = distance / activeDistance
                    let zoomAddition = zoomFactor * (1 - normalizedDistance.magnitude)
                    let widthAddition = attributes.frame.width * zoomAddition / 2
                    dx = dx + widthAddition * direction

                    if zoom {
                        let scale = 1 + zoomAddition
                        attributes.transform3D = CATransform3DMakeScale(scale, scale, 1)
                        attributes.zIndex = Int(scale.rounded())
                    }
                }
            }
        }

        adjustXPosition(visibleAttributes, direction: +1)
        adjustXPosition(visibleAttributes.reversed(), direction: -1, zoom: true)
        
        return rectAttributes
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return .zero
        }
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
    
}

