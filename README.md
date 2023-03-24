# News App
Naver news 검색 API를 활용한 iOS 어플리케이션.

## Description
+ 최소 타겟 : iOS 14.5
+ CleanArchitecture + MVP 패턴 적용
+ CoreData 프레임워크 사용으로 즐겨찾기 목록 유지
+ Storyboard를 활용하지 않고 코드로만 UI 구성
+ Pagination 구현
+ Unit Test 진행
+ [개발 공수]()

## Feature
+ 기사 검색 뷰
  + 카테고리별 기사 검색 기능
  + 페이지네이션 - prefetching 방식
  + refreshing 기능
+ 태그 설정 뷰
  + Compositional layout을 통한 self-sizing CollectionView
  + delegate 패턴을 통한 데이터 전달
+ 디테일 웹 뷰
  + 스크랩 추가/제거
  + 액티비티 인디케이터
  + WebView 기반 연결
  + 링크 클립보드 복사
+ 스크랩 뷰
  + 스크랩 목록 관리
  + 스크랩 데이터 제거


## Getting Start
> Swift, MVP, CI/CD, Unit Test, CoreData, WebKit, SnapKit, Alamofire, Toast-swift, TTGTagCollectionView

## Issue

### 1. TableView reloadData()에서 Section Header 영역 리로드로 인해서 Tag가 계속 추가적으로 생성되는 상황 발생

Header의 내부 메서드 setup() 실행에 있어서 delegate는 유지하고 추가적인 생성은 분기처리를 통해 해결, 이전 tags의 요소 내 String 값에 접근하는 것이 제한적이라 가능한 접근하여 해당 배열을 생성하여 비교 후 태그 설정 하도록 분기 처리

```swift
func setup(tags: [String], delegate: NewsListViewHeaderDelegate) {
        self.tags = tags
        self.delegate = delegate
        contentView.backgroundColor = .systemBackground
        setupLayout()
        let prevTags = tagCollectionView.allTags().compactMap { tag in
            "\(tag.content)"
                .replacingOccurrences(
                    of: "<TTGTextTagStringContent: self.text=",
                    with: ""
                )
                .replacingOccurrences(
                    of: ">",
                    with: ""
                )
        }
        if prevTags != tags {
            tagCollectionView.removeAllTags()
            setupTagCollectionView()
        }
    }
```

### 2. Test Coverage
Presenter의 unit test에 있어서 최대한 coverage를 만족시킬 것을 고려하고 필요에 따라 BDD처럼 조건 분기에 대한 처리를 통하여 테스트 케이스 분리

<img src = "https://user-images.githubusercontent.com/75239459/177030264-64a065ec-05a1-4396-99b3-7b0ee18b5831.png" width = 500>
<img src = "https://user-images.githubusercontent.com/75239459/177030259-da8e6b46-0388-4c92-8f31-241defb270fe.png" width = 500>
<img src = "https://user-images.githubusercontent.com/75239459/177030261-499c8674-4ff2-41cd-9142-4daa90727436.png" width = 500>
<img src = "https://user-images.githubusercontent.com/75239459/177030262-68ecfd8f-6064-4c6f-ab85-a07a696af0f6.png" width= 500>


### 3. Bitrise 사용 CI / CD 환경 구축 시 Secrets 구성 이슈

기존에는 .xcconfig 확장자의 파일로 관리하면서 API Key를 관리했었다. 하지만, CI 환경을 구성하고 리모트 빌드 되는 환경에서 해당 파일은 .gitignore에 의해서 업로딩이 제한되고 결국에는 빌드가 되지 않는 문제가 발생했다.

이럴 경우, fastLane, github action, jenkins 등 다른 솔루션들도 secrets와 env var를 제공하면서 내부에서 보안적인 경우를 해결 할 수 있도록 구성이 가능하다고 한다.

따라서, 기존의 활용하던 .xcconfig를 걷어내고 간단하게 bitrise상에서 secrets를 변수로 설정하고 해당 값을 가져오는 방식으로 바꾸어 우선은 repo에 commit 해두었고 remote build 상 문제없이 구성할 수 있었다.

<img src = "https://user-images.githubusercontent.com/75239459/176087060-3ee299b9-da95-43bf-ac53-cfe142014e79.png" width = 500>

+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 1](https://medium.com/hongbeomi-dev/bitrise%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-ci-cd-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0-1-firebase-distribution-cd522d53465c)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 2](https://www.youtube.com/watch?v=PGh_RPYA45w)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 3](https://www.runway.team/blog/how-to-set-up-a-ci-cd-pipeline-ios-app-using-bitrise)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 4](https://stackoverflow.com/questions/65828851/how-to-access-bitrise-secret-environment-variable-in-swift-code)
+ [환경 변수 설정 및 Secret 구성을 통한 관리 방식 레퍼런스 5](https://ios-development.tistory.com/749)

### 4. CoreData를 이용한 기사 스크랩 관련 모델 문제

기존에 다루던 News 구조체와 CoreData에서 쓰는 ScrapedNews 구조체의 형태는 동일하나 다르게 쓸 수 밖에 없었다. 외부에서 가져오는 엔티티의 형태와 동일 하더라도 내부의 Database에 쓰인다는 의미는 아무래도 불변성에 근거하여 이를 임의적으로 수정하는 건 제한하는 것 같았다. 따라서, 서로 다른 네이밍으로 관리하고 필요에 따라서 DB에서 가져온 데이터를 파싱하여 엔티티의 데이터 형태로 사용하는게 오히려 안전하다고 생각되어 우선은 분리한 채 작업을 진행해두었다.

#### CoreData 활용과 유닛 테스트

MockData를 구성함에 있어서 분리가 있다보니 마음대로 조작된 데이터를 주입하기가 까다로웠다. 간단하게 전달되는 함수만 구현하는 것이 아닌 실제로 DB 내부에 데이터를 주입하고 테스트하는 방식을 고려하게 되면서 기존에 있던 가벼운 수준의 Test Mock을 덜어내고 다시 구성을 시작했다. 구체적으로 CoreData를 경유하여 News 값을 전달하고 삭제하는 로직을 추가하여 구성하였다.

[참고 레퍼런스](https://medium.com/tiendeo-tech/ios-how-to-unit-test-core-data-eb4a754f2603)</br>
[참고 레퍼런스 레포](https://github.com/Haeuncs/MemoApp/blob/master/MemoAppTests/MemoAppTests.swift)

### 5. LargeTitle 관련 rightBarButton 위치 문제

Large 타이틀은 유지하면서 네비게이션 버튼의 위치를 적절한 곳에 위치 시키고 싶었으나, 확실히 조정하는 게 생각보다 어려웠다. 일반적인 UI button으로 구성하여 bar에 올리는 방식을 추천하여 생명주기에 따라서 해당 뷰를 보여주는 방식으로 구현했다. 오토레이아웃이 생각보다 까다롭고 버튼의 사이즈에 관계하여 뷰 자체가 망가지는 경우도 생기므로 주의하면서 세팅해야할 거 같았다.

<img src = "https://i.stack.imgur.com/2XLBi.gif" width = 400>

+ [참고 레퍼런스](https://stackoverflow.com/questions/45317963/adjust-position-of-bar-button-item-when-using-large-titles-with-ios-11)

### 6. 되도록 클린하게

이번 프로젝트를 진행하면서 최대한 관리가 용이한 방법으로 하되 기존에 사용했던 MVP의 특성을 잃고 싶지 않았다. 외부에서 데이터를 다루는 Repo와 같은 역할은 Manager에게 일임하고 될 수 있으면 protocol로 분리하여 그 역할을 구분지어 두었다. 또한 네트워크 구성에 있어서도 한 곳에 몰아두는 방식 보다는 분리를 통해서 유지 보수가 원활하도록 구성하는 편이 좋기에 분리하였고, 쓰면서 Moya 등의 서드파티가 잘 짜여졌다고 느꼈다. 클린하게 작성한다는 건 가장 와 닿는 건 역할의 분리와 데이터 주입 등 생각해야할 부분이 많다는 것이다. 기존에 뭉탱이로 작업하던 코드들과는 달리 주입방식의 코드와 외부의 분리를 통한 호출은 확실히 테스트 하기에도 굉장히 용이하다.

또한 와닿은 건 DI의 분리와 확실한 레이어 구분이었다. Data 레이어, 엔티티 등 서로가 절대 알아선 안되는 경우에 대해서는 확실하게 구분하고 현재 구성한 Presenter, View의 관계에 있어서도 참조 관계에 대해서도 역할을 명확히 하는게 중요했다. 그리고 구성하면서 느낀 건데 View에서 화면 전환 로직에 있어서 의존성 주입이 있는데 해당 부분은 Cordinator, Container 등으로 분리하여 직접적으로 View에서 모델을 인젝션 하는 건 맞지 않아 보였다.

### 7. 웹 뷰에서 전달된 인터렉션의 결과로 네이티브의 인터렉션이 동작하지 않는 문제

swift의 대부분의 UI 요소에는 UIResponder가 있다. 처리되지 않은 이벤트는 리스폰더 체인을 통해 랩핑된 view로 전달되게 되는데, 내 생각에 WKWebView는 창이 활성화되면 모든 터치 이벤트를 흡수한다. 아무리 터치해도 프린트가 도저히 동작하지 않아 고민하다가 webView 내의 인터렉션을 시도한 후에야 정상적으로 이벤트 전달이 발생했다. 이 후 리스폰더를 간단하게 작성하므로써 해결!

+ [참고 레퍼런스](https://stackoverflow.com/questions/56332558/uibutton-selector-not-working-after-button-tapped-within-wkwebview)

### 8. Compositional layout을 통한 self-sizing

+ [참고 레퍼런스 1](https://munokkim.medium.com/wwdc20-%ED%95%9C%EA%B8%80%EB%B2%88%EC%97%AD-lists-in-uicollectionview-ed47aa6793f9)
+ [참고 레퍼런스 2](https://stackoverflow.com/questions/59416438/uicollectionviewcompositionallayout-with-self-sizing-cells)

## ScreenShot
![IMG_C017886C83C0-1](https://user-images.githubusercontent.com/75239459/177031272-ac8138e1-b619-4bf3-be6e-d2d23e0c87c7.png)
