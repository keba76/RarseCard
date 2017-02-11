//
//  CardVC.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/6/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class CardVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let dis = DisposeBag()
    var newCommentBtn: ActionButton!
    
    lazy var itemDetailsSegue: Segue<Void> = {
        Segue(fromViewController: self, toViewControllerFactory: { _ -> NewCommentVC in
            let vc: NewCommentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController()
            //vc.card = context
            return vc
        })
    }()
    
    var card: IntItem?
    private var headerView: CardHeaderView!
    var tableHeaderHeight: CGFloat = 320.0
    private var headerMaskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 170.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        headerView = tableView.tableHeaderView as! CardHeaderView
        headerView.card = card
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: (tableHeaderHeight-20.0), left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -(tableHeaderHeight-20.0))
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        
        updateHeaderView()
        
        newCommentBtn = ActionButton(attachedToView: self.view, items: nil)
        newCommentBtn.floatButton.rx.tap.bindTo(itemDetailsSegue.presentObserver).addDisposableTo(dis)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -(tableHeaderHeight-20.0), width: tableView.bounds.width, height: tableHeaderHeight)
        if tableView.contentOffset.y < -(tableHeaderHeight-20.0) {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + 20.0
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - 40.0))
        headerMaskLayer?.path = path.cgPath
        
        headerView.frame = headerRect
    }

}
extension CardVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
        
        let offsetY = scrollView.contentOffset.y
        if -offsetY > tableHeaderHeight + 150.0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension CardVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.comment = card
        
        return cell
    }
}
