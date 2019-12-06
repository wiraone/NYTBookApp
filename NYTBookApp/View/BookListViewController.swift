//
//  BookListViewController.swift
//  NYTBookApp
//
//  Created by wirawan on 5/12/19.
//  Copyright © 2019 wirawan. All rights reserved.
//

import Foundation
import UIKit

class BookListViewController: UIViewController {

    @IBOutlet weak var booksTableView: UITableView!
    private var bookListPresenter: BookListPresenter?
    private var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bookListPresenter = self.bookPresenter()
        self.bookListPresenter?.delegate = self
        self.bookListPresenter?.fetchBooks()

        // Add pull to refresh
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.booksTableView.addSubview(refreshControl)
    }

    func bookPresenter() -> BookListPresenter {
        let networkLayer = Network()
        let booksModel = BookListModel(networkLayer: networkLayer)
        let bookListPresenter = BookListPresenter(bookListModel: booksModel)
        return bookListPresenter
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailBook"{
            if let vc = segue.destination as? BookDetailViewController {
                vc.book = sender as? Book
            }
        }
    }

    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        bookListPresenter?.refreshBooksByPullToRefresh()
        bookListPresenter?.fetchBooks()
    }
}

extension BookListViewController: BookListPresenterDelegate {
    func didFetchBooks(success: Bool) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.booksTableView.reloadData()
        }
    }
}

extension BookListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return (bookListPresenter?.isLoadMoreEnable() ?? false) ? 2 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (self.bookListPresenter?.booksCount())!
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            cell?.textLabel?.text = self.bookListPresenter?.bookName(index: indexPath.row)
            cell?.detailTextLabel?.text = self.bookListPresenter?.bookAuthor(index: indexPath.row)
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadMoreCell")
            return cell!
        }
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let book = self.bookListPresenter?.bookAt(index: indexPath.row)
            self.performSegue(withIdentifier: "segueToDetailBook", sender: book)
            break
        default:
            bookListPresenter?.loadMoreData()

            DispatchQueue.main.async {
                self.booksTableView.reloadData()
            }
            break;
        }
    }
}
