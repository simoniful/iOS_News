//
//  NewsListViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NewsListViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let newsListView = NewsListView()
    private var viewModel: NewsListViewModel
    private lazy var input = NewsListViewModel.Input(
        didSelectRowAt: newsListView.tableView.rx.modelSelected(News.self).asSignal(),
        rightBarButtonTapped: newsListView.rightBarButton.rx.tap.asSignal(),
        refreshSignal: newsListView.refreshControl.rx.controlEvent(.valueChanged).asSignal(),
        prefetchRowsAt: newsListView.tableView.rx.prefetchRows.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = newsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupRightButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeRightButton()
    }
}

private extension NewsListViewController {
    func setupNavigationBar() {
        title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupRightButton() {
        navigationController?.navigationBar.addSubview(newsListView.rightBarButton)
        guard let targetView = self.navigationController?.navigationBar else { return }
        newsListView.rightBarButton.snp.makeConstraints {
            $0.trailing.equalTo(targetView.snp.trailing).inset(16.0)
            $0.bottom.equalTo(targetView.snp.bottom).inset(8.0)
            $0.width.equalTo(30.0)
            $0.height.equalTo(30.0)
        }
    }
    
    func removeRightButton() {
        guard let subviews = self.navigationController?.navigationBar.subviews else { return }
        for view in subviews{
            if view.tag != 0 {
                view.removeFromSuperview()
            }
        }
    }
    
    func bind() {
        newsListView.tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        output.newsList
            .drive(newsListView.tableView.rx.items) { tableView, index, element in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListViewCell.identifier) as? NewsListViewCell else { return UITableViewCell() }
                cell.setup(news: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.endRefreshing
            .emit(onNext: { [weak self] _ in
                self?.newsListView.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        output.scrollToTop
            .emit(onNext: { [weak self] _ in
                self?.newsListView.tableView.scrollToRow(
                    at: IndexPath(row: 0, section: 0),
                    at: .top,
                    animated: true
                )
            })
            .disposed(by: disposeBag)
        
        output.reloadTable
            .emit(onNext: { [weak self] _ in
                self?.newsListView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.showToastAction
            .emit(onNext: { [weak self] text in
                self?.view.makeToast(text)
            })
            .disposed(by: disposeBag)
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListViewHeader.identifier) as? NewsListViewHeader else { return UITableViewHeaderFooterView() }
        header.setup(tags: viewModel.tags, delegate: viewModel)
        return header
    }
}

