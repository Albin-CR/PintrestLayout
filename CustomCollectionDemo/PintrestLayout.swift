//
//  PintrestLayout.swift
//  CustomCollectionDemo
//
//  Created by Albin.git on 6/30/17.
//  Copyright © 2017 Albin.git. All rights reserved.
//

import UIKit

protocol PintrestlayoutDelegate{
    
    func collectionView(collectionView:UICollectionView,heightForItemAtIndexPath indexPath:IndexPath) -> CGFloat
    
}
class PintrestLayoutAttributes: UICollectionViewLayoutAttributes{
    
    var cellHeight:CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        
        if let copy = super.copy(with: zone) as? PintrestLayoutAttributes{
            copy.cellHeight = cellHeight
            return copy
        }else{
            return 1
        }
        
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let attribute = object as? PintrestLayoutAttributes{
            if attribute.cellHeight == cellHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}


class Pintrestlayout:UICollectionViewLayout{
    
    var cellPadding = 0
    var delegate:PintrestlayoutDelegate!
    var numberOfColumns = 1
    
    
    private var cache:[UICollectionViewLayoutAttributes] = []
    private var contentHeight:CGFloat = 0
    private var width:CGFloat{
        get {
            let inset = collectionView!.contentInset
            return collectionView!.bounds.width - (inset.left + inset.right)
        }
    }
    
    //    override func collectionViewContentSize() -> CGSize {
    //
    //        return CGSize(width:width,height:contentHeight)
    //    }
    
    override var collectionViewContentSize: CGSize{
        
        get{
            return CGSize(width:width,height:contentHeight)
        }
        
    }
    
    
    override func prepare() {
        
        if cache.isEmpty{
            
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffset:[CGFloat] = []
            
            for column in 0..<numberOfColumns{
                
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            var yOffset:[CGFloat] = [CGFloat](repeating:0,count:numberOfColumns)
            var column = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0){
                
                let indexPath:IndexPath = IndexPath(item: item, section: 0)
                let width =  columnWidth - CGFloat(cellPadding * 2)
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x:xOffset[column],y:yOffset[column],width:width,height:height)
                let insetFrame = frame.insetBy(dx: CGFloat(cellPadding), dy: CGFloat(cellPadding))
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                attributes.frame = insetFrame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : (column + 1)
            }
            
        }
        
        
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes:[UICollectionViewLayoutAttributes] = []
        
        for attribute in cache {
            if attribute.frame.intersects(rect){
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    
    
}




