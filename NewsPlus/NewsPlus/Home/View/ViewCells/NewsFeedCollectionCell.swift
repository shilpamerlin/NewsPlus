//
//  NewsFeedCollectionCell.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-25.
//

import UIKit

class NewsFeedCollectionCell: UICollectionViewCell {
    @IBOutlet weak var newsFeedImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsFeedPublishDate: UILabel!
    @IBOutlet weak var newsFeedTitle: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView?.layer.cornerRadius = 10
        containerView?.layer.masksToBounds = true
    }
    
    // MARK: - Helpers
    
    func configure(feed: NewsFeedCellModel) {
        newsFeedTitle?.text = feed.title
        let date = feed.feedUpdateDate == nil ? feed.publishDate : feed.feedUpdateDate
        let trimDate = date?.dropLast(7)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy, HH:mm:ss"
        let formatedDate = formatter.date(from: String(trimDate!))
        if Calendar.current.isDateInToday(formatedDate!) {
            newsFeedPublishDate.text = formatedDate?.getElapsedInterval()
        } else {
            newsFeedPublishDate.text = date
        }
        guard let imageUrl = feed.imageUrl else { return }
        newsFeedImageView?.loadImageUsingCache(withUrl: imageUrl)
    }
}
