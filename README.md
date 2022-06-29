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

### 3. Bitrise 사용 CI / CD 환경 구축 시 Secrets 구성 이슈

기존에는 .xcconfig 확장자의 파일로 관리하면서 API Key를 관리했었다. 하지만, CI 환경을 구성하고 리모트 빌드 되는 환경에서 해당 파일은 .gitignore에 의해서 업로딩이 제한되고 결국에는 빌드가 되지 않는 문제가 발생했다.

이럴 경우, fastLane, github action, jenkins 등 다른 솔루션들도 secrets와 env var를 제공하면서 내부에서 보안적인 경우를 해결 할 수 있도록 구성이 가능하다고 한다.

따라서, 기존의 활용하던 .xcconfig를 걷어내고 간단하게 bitrise상에서 secrets를 변수로 설정하고 해당 값을 가져오는 방식으로 바꾸어 우선은 repo에 commit 해두었고 remote build 상 문제없이 구성할 수 있었다.

![image](https://user-images.githubusercontent.com/75239459/176087060-3ee299b9-da95-43bf-ac53-cfe142014e79.png)

+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 1](https://medium.com/hongbeomi-dev/bitrise%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-ci-cd-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-1-firebase-distribution-cd522d53465c)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 2](https://www.youtube.com/watch?v=PGh_RPYA45w)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 3](https://www.runway.team/blog/how-to-set-up-a-ci-cd-pipeline-ios-app-using-bitrise)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 4](https://stackoverflow.com/questions/65828851/how-to-access-bitrise-secret-environment-variable-in-swift-code)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 5](https://ios-development.tistory.com/749)

### 4. CoreData를 이용한 기사 스크랩

## ScreenShot


## Video
