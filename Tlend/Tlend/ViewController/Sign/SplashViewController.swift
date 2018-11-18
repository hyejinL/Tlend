//
//  SplashViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 18..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    let datas: [SplashData] = [.init(title: "나의 아티스트를 위한\n가장 쉬운 방법, 트렌드",
                                     content: "나의 아이돌을 위한 선물\n나를 위한 굿즈",
                                     image: #imageLiteral(resourceName: "walkthrough8121.png")),
                               .init(title: "하나하나 찾지말고\n여기서 다 해결해요",
                                     content: "아티스트들의 최신정보, 컴백무대 등\n핫 이슈를 확인해보세요",
                                     image: #imageLiteral(resourceName: "walkthrough8122.png")),
                               .init(title: "내가 응원하는 아티스트를\n유행시켜보세요",
                                     content: "내새끼를 선택해보세요\n선택된 수는 랭킹에 반영됩니다",
                                     image: #imageLiteral(resourceName: "walkthrough8123.png"))]
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPagingEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension SplashViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard datas.count > indexPath.item else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
            return cell
        }
        let cell = collectionView.dequeue(SplashCollectionViewCell.self, for: indexPath)
        cell.configure(data: datas[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count + 1
    }
    
    
}

extension SplashViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        if pageControl.currentPage == 3 {
            let vc = UIStoryboard(name: "Sign", bundle: nil).instantiateViewController(ofType: LandingViewController.self)
            let navi = UINavigationController(rootViewController: vc)
            self.present(navi, animated: true, completion: nil)
        }
    }
}


struct SplashData {
    var title: String
    var content: String
    var image: UIImage
}
