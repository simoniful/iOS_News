//
//  NewsScrapViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NewsScrapViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let newsScrapView = NewsScrapView()
    private var viewModel: NewsScrapViewModel
    private lazy var input = NewsScrapViewModel.Input(
        didSelectRowAt: newsScrapView.tableView.rx.modelSelected(ScrapedNews.self).asSignal(),
        deleteForRowAt: newsScrapView.tableView.rx.itemDeleted.asSignal(),
        viewWillAppear: self.rx.viewWillAppear.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)

    init(viewModel: NewsScrapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = newsScrapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bind()
    }
}

private extension NewsScrapViewController {
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Bookmark"
    }
    
    func bind() {
        newsScrapView.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        output.scrapedNewsList
            .drive(newsScrapView.tableView.rx.items) { tableView, index, element in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsScrapViewCell.identifier) as? NewsScrapViewCell else { return UITableViewCell() }
                cell.setup(scrapedNews: element)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension NewsScrapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}






