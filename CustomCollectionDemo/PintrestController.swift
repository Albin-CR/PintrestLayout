//
//  ViewController.swift
//  CustomCollectionDemo
//
//  Created by Albin.git on 6/29/17.
//  Copyright © 2017 Albin.git. All rights reserved.
//

enum Cells:String{
    
    case pintrestCell = "pintrestCell"
    
}


class PintrestCell: UICollectionViewCell {
    
    
}

import UIKit
let screenSize = UIScreen.main.bounds
class PintrestController: UIViewController {
    
    var collectionView:UICollectionView = {
        
        let collectionViewFlowLayout =  Pintrestlayout()
        
        let collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .green
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupViews()
        registerCells()
        
        if let layout = self.collectionView.collectionViewLayout as? Pintrestlayout{
            layout.delegate = self
            layout.numberOfColumns = 3
            layout.cellPadding = 1
        }
        
        
    }
    
    func registerCells() {
        
        collectionView.register(PintrestCell.self, forCellWithReuseIdentifier: Cells.pintrestCell.rawValue)
        
    }
    
    func setupViews(){
        
        view.backgroundColor = .yellow
        view.addSubview(collectionView)

        collectionView.dataSource = self
        
        collectionView.fillSuperview()
        
    }
    
}


extension PintrestController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.pintrestCell.rawValue, for: indexPath)
        cell.layer.zPosition = 0
        let currentCell = cell as? PintrestCell
        currentCell?.layer.zPosition = 0
        currentCell?.backgroundColor = .blue
        currentCell?.contentView.backgroundColor = UIColor.red
        
        return cell
    }
    
    
    
    
}

extension PintrestController:UICollectionViewDelegate{
    // MARK: - Selecting cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}

extension PintrestController:PintrestlayoutDelegate{
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return (CGFloat((arc4random_uniform(4) + 1 )) * 100)
    }
    
}
