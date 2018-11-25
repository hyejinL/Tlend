//
//  ContentDetailViewController.swift
//  Tlend
//
//  Created by KanghoonOh on 2018. 11. 19..
//  Copyright © 2018년 LeeHyeJin. All rights reserved.
//

import UIKit
import MMPlayerView
import AVFoundation

class ContentDetailViewController: UIViewController {
    
    struct Const {
        static let detailNavi: String = "DetailViewNavigationController"
    }
    
    enum Section: Int, CaseIterable {
        case image
        case video
        case header
        case items
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var mmPlayerLayer: MMPlayerLayer = {
        let l = MMPlayerLayer()
        
        l.cacheType = .memory(count: 1)
        l.coverFitType = .fitToPlayerView
        l.videoGravity = AVLayerVideoGravity.resizeAspect
        l.replace(cover: CoverA.instantiateFromNib())
        return l
    }()
    
    var mediaID: Int?
    var itemList: [TlendItem] = []
    var detailMedia: DetailMedia?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading(.start)
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    private func getData() {
        ContentService.shared.getMedia(mediaID: mediaID ?? 0) { [weak self] result in
            switch result {
            case .success(let data):
                self?.itemList = data.itemList
                self?.detailMedia = data.media
                self?.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ContentDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section),
            itemList.count > indexPath.row else { return }
        if section == .items {
            let item = itemList[indexPath.row]
            
            let navigationController = UIStoryboard(name: "Detail", bundle: nil)
                .instantiateViewController(withIdentifier: Const.detailNavi)
            guard let viewController = navigationController.children
                .first as? DetailInfoViewController,
                let type = item.detailType else { return }
            viewController.detailType = type
            
            switch type {
            case .support:
                viewController.starIdx = item.idolID
                viewController.detailIdx = item.supportIdx
            case .reward:
                viewController.starIdx = item.idolID
                viewController.detailIdx = item.rewardIdx
            }
        }
    }
}

extension ContentDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .image, .video, .header:
            return 1
        case .items:
            return itemList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .image:
            guard let media = detailMedia else { return UITableViewCell() }
            let cell = tableView.dequeue(ContentImageTableViewCell.self, for: indexPath)
            cell.delegate = self
            cell.configure(media.detailImage)
            return cell
        case .video:
            guard let media = detailMedia else { return UITableViewCell() }
            let cell = tableView.dequeue(ContentVideoTableViewCell.self, for: indexPath)
            mmPlayerLayer.thumbImageView.image = cell.videoImageView.image

            if !MMLandscapeWindow.shared.isKeyWindow {
                mmPlayerLayer.playView = cell.videoImageView
            }
            
            mmPlayerLayer.set(url: URL(string: media.videoKey))
            mmPlayerLayer.resume()
            return cell
        case .header:
            return tableView.dequeueReusableCell(withIdentifier: "ContentItemHeader", for: indexPath)
        case .items:
            guard itemList.count > indexPath.row else { return UITableViewCell() }
            let cell = tableView.dequeue(ContentItemTableViewCell.self, for: indexPath)
            cell.configure(itemList[indexPath.row])
            return cell
        }

    }
}

extension ContentDetailViewController: ContentImageProtocol {
    func setImageHeight() {
        self.loading(.end)
        UIView.performWithoutAnimation { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
}

extension ContentDetailViewController: MMPlayerFromProtocol {
    func backReplaceSuperView(original: UIView?) -> UIView? {
        return original
    }
    
    var passPlayer: MMPlayerLayer {
        return self.mmPlayerLayer
    }

    func transitionWillStart() {
        self.mmPlayerLayer.playView?.isHidden = true
    }

    func transitionCompleted() {
        self.mmPlayerLayer.playView?.isHidden = false
    }
    
    func dismissViewFromGesture() {
        mmPlayerLayer.thumbImageView.image = nil
    }
    
    func presentedView(isShrinkVideo: Bool) {
        self.tableView.visibleCells.forEach {
            if ($0 as? ContentVideoTableViewCell)?.videoImageView.isHidden == true && isShrinkVideo {
                ($0 as? ContentVideoTableViewCell)?.videoImageView.isHidden = false
            }
        }
    }
}
