# News App
Naver news 검색 API를 활용한 iOS 어플리케이션.

## Description
+ 최소 타겟 : iOS 14.5
+ MVP 패턴 적용
+ Core Data 프레임워크 사용으로 즐겨찾기 목록 유지
+ Storyboard를 활용하지 않고 코드로만 UI 구성
+ Pagination 구현
+ 개발 공수

## Feature
+ 검색 뷰
  + 카테고리별 기사 검색 기능
  + 페이지네이션
  + 로딩 액티비티 인디케이터
+ 디테일 뷰
  + 즐겨찾기 추가/제거
  + 액티비티 인디케이터
  + WebView 기반 연결
  + 링크 클립보드 복사
+ 즐겨찾기 뷰
  + 즐겨찾기 목록 관리
  + 즐겨찾기 데이터 제거

## Getting Start
> Swift
MVP, CI/CD, Unit Test
UIKit, SnapKit
Alamofire
TTGTagCollectionView

## Issue

### 1. TableView reloadData()에서 Section Header 영역 리로드로 인해서 Tag가 계속 생성되는 상황 발생

Header의 내부 메서드 setup() 실행에 있어서 delegate는 유지하고 추가적인 생성은 분기처리를 통해 해결

```swift
func setup(tags: [String], delegate: NewsListViewHeaderDelegate) {
        self.tags = tags
        self.delegate = delegate
        contentView.backgroundColor = .systemBackground
        setupLayout()
        if tagCollectionView.allTags().count != tags.count {
            setupTagCollectionView()
        }
    }
```

### 2. Test Coverage
Presenter의 unit test에 있어서 최대한 coverage를 만족시킬 것을 고려하고 필요에 따라 BDD처럼 조건 분기에 대한 처리를 통하여 테스트 분리

![image](https://user-images.githubusercontent.com/75239459/175867790-e2f1c566-d1eb-467d-9e20-1cf52c93cb98.png)

## ScreenShot


## Video
