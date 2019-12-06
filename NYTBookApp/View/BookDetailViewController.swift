//
//  BookDetailViewController.swift
//  NYTBookApp
//
//  Created by wirawan on 6/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation
import Nuke
import UIKit

class BookDetailViewController: UITableViewController {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookPublisherLabel: UILabel!
    @IBOutlet weak var bookRankLabel: UILabel!
    @IBOutlet weak var bookCoverImageView: UIImageView!

    var book: Book?
    private var bookDetailPresenter: BookDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookDetailPresenter = self.bookPresenter()
        self.setupContent()
      }

    func bookPresenter() -> BookDetailPresenter {
        let bookPresenter = BookDetailPresenter(book: self.book)
        return bookPresenter
    }
}

extension BookDetailViewController {
    func setupContent() {
        self.bookTitleLabel.text = bookDetailPresenter?.bookName()
        self.bookPublisherLabel.text = bookDetailPresenter?.bookPublisher()
        self.bookDescLabel.text = bookDetailPresenter?.bookDescription()
        self.bookAuthorLabel.text = bookDetailPresenter?.bookAuthor()
        self.bookRankLabel.text = "\(bookDetailPresenter?.bookRanking() ?? 0)"

        if let imageURL = URL.init(string: bookDetailPresenter?.bookCoverImageURL() ?? "") {
            Nuke.loadImage(with: imageURL, into: self.bookCoverImageView)
        }
    }
}
