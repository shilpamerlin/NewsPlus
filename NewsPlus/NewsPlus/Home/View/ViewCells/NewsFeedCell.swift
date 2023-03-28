//
//  NewsFeedCell.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-22.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    @IBOutlet weak var newsFeedTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var newsFeedImage: UIImageView!
    
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
            publishDate.text = formatedDate?.getElapsedInterval()
        } else {
            publishDate.text = date
        }
        guard let imageUrl = feed.imageUrl else { return }
        newsFeedImage?.loadImageUsingCache(withUrl: imageUrl)
    }
}
