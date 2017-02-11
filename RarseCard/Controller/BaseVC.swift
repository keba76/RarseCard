//
//  BaseVC.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/6/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BaseVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var currentUser: UIButton!
    @IBOutlet weak var newCard: UIButton!
    let dis = DisposeBag()
    
    lazy var itemNewCardSegue: Segue<Void> = {
        Segue(fromViewController: self, toViewControllerFactory: { _ -> NewCardVC in
            let vc: NewCardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController()
            //vc.card = context
            return vc
        })
    }()
    
    lazy var itemDetailsSegue: Segue<IntItem> = {
        Segue(fromViewController: self, toViewControllerFactory: { context -> CardVC in
            let vc: CardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController()
            vc.card = context
            return vc
        })
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var dataSourse: RxCollectionViewSectionedAnimatedDataSource<NumberSection>?
    
    
    let model: [NumberSection] = [NumberSection(header: "Section1", numbers: [IntItem(comment: Comments(), user: Users(), cars: Cars(name: "BmwM4", description: "Nice car", image: UIImage(named: "bmwM4")!))]),
                                  NumberSection(header: "Section2", numbers: [IntItem(comment: Comments(), user: Users(), cars: Cars(name: "BmwM5", description: "Nice car", image: UIImage(named: "bmwM5")!))]),
                                  NumberSection(header: "Section3", numbers: [IntItem(comment: Comments(), user: Users(), cars: Cars(name: "BmwM6", description: "Nice car", image: UIImage(named: "bmwM6")!))]),
                                  NumberSection(header: "Section4", numbers: [IntItem(comment: Comments(), user: Users(), cars: Cars(name: "BmwM6(coupe)", description: "Nice car", image: UIImage(named: "bmwM6(coupe)")!))])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "cloud1")
        let blurEfect = UIBlurEffect(style: .dark)
        let blurEfectView = UIVisualEffectView(effect: blurEfect)
        blurEfectView.frame = view.bounds
        backgroundImage.addSubview(blurEfectView)
        
        dataSourse = RxCollectionViewSectionedAnimatedDataSource<NumberSection>()
        dataSourse?.configureCell = {ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(withReuseIdentifier: "CardCell", for: ip) as! CardCell
            cell.card = item
            return cell
        }
        
        Observable.of(model).bindTo(collectionView.rx.items(dataSource: dataSourse!)).addDisposableTo(dis)
        
        collectionView.rx.modelSelected(IntItem.self).bindTo(itemDetailsSegue.presentObserver).addDisposableTo(dis)
        
        newCard.rx.tap.bindTo(itemNewCardSegue.presentObserver).addDisposableTo(dis)
    }
}


