# News App
Naver news 검색 API를 활용한 iOS 어플리케이션.

## Description
+ 최소 타겟 : iOS 14.5
+ CleanArchitecture + MVVM-C 패턴 적용
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
  + 즐겨찾기 추가/제거
  + 액티비티 인디케이터
  + WebView 기반 연결
  + 링크 클립보드 복사
+ 스크랩 뷰
  + 스크랩 목록 관리
  + 스크랩 데이터 제거

## Getting Start
> Swift, MVVM+C, CI/CD, Unit Test, CoreData, WebKit, SnapKit, Alamofire, Toast-swift, TTGTagCollectionView, RxCocoa, RxSwift, RxTest

## Issue & Reflection

### 1. Coordinator 구성 및  Tabbar / Navigation 연결

처음 코디네이터 패턴을 구성하다 보니 이해하는데 꽤 시간이 들었다. `생성자 주입`을 통해 navigationController를 주입받고, 화면전환 시 해당 `navigationController`가 다음 화면을 push 하도록 구성했다.  확실히 직접적인 `ViewModel`에서의 ViewController 생성과 DI를 피하고 Container를 통해서 하다보니 View 자체에서는 Model에 대해서 더욱 알 수 없도록 구성했다는 점에선 만족이다. 조금 의문점은 화면전환 동작을 클로저 타입으로 actions에 저장하고, actions를 ViewModel의 init 시 주입하는 방법도 고려해봐야 할 거 같다.

### 2. Test Coverage

ViewModel의 unit test에 있어서 최대한 coverage를 만족시킬 것을 고려하고 필요에 따라 BDD처럼 조건 분기에 대한 처리를 통하여 테스트 케이스 분리했다. 테스트 구성에 있어서 MVP 패턴의 Presenter와 비교할 경우 커버리지는 상당히 높을 수 밖에 없었다. 하지만, In/Out 패턴에 대한 생각과 전반적인 커버리지가 아닌 구체적인 테스트 케이스를 어떻게 구성할 지 고민하게 되었다.

<img src = "https://user-images.githubusercontent.com/75239459/179142866-a446a50f-ab1e-43b8-a3ce-8a2b8da7425c.png" width = 500>
<img src = "https://user-images.githubusercontent.com/75239459/179142934-7482a9f2-c7a9-45a4-94b7-114b1bf3ef44.png" width = 500>
<img src = "https://user-images.githubusercontent.com/75239459/179142978-ff7fa1ee-7978-4116-b652-06db09efa5b7.png" width = 500>
<img src = "https://user-images.githubusercontent.com/75239459/179143022-024d2771-ab7b-4a4e-9477-c7e8e3ce2dee.png" width= 500>

#### Test에서 In/Out의 제한점과 테스트를 시나리오에 따라 분리 구성하는 방법에 대한 고민

내부 구조체에 얽매이다 보니 전체에 대한 Default Input 이벤트를 구성해서 테스트 케이스를 구성하게 되었다. 전반적인 테스트 시행에 있어서는 장점도 있었지만 스트림을 분기 단위 별로 시나리오에 맞춰 구성하는 데 제약이 있었던 거 같다. 따라서, 분리해서 적잘한 스트림을 전달하는 방식과 혹은 모델 단위별로 분리해서 내부의 로직만 확인하도록 구성하는 방법도 생각해봐야한다.

아키텍쳐에 집중하여 아주 작은 수준의 프로젝트를 진행하다보니 복잡한 수준의 기능이 없어서 구현에는 큰 어려움이 없었다. 하지만, 실제 프로젝트에선 복잡한 뷰나 기능 구현과 뷰의 애니메이션 같은 경우에도 고려하여 다음 프로젝트 때에는 조금은 더 신경 써봐야겠다. UI Test도 포함해서 말이다.

### 3. Rx In/Out 형식의 ViewModel 구성 및 처리

Signal, Drive 등의 Traits를 적극적으로 활용했다. 하지만 구성하면서 의문이 생긴 건 emit(), drive() 등 onNext 내부에 로직을 구성하는 것이 아닌 외부로 정리해서 분리하는 것도 방법이라고 생각했다. 확실히 ViewModel이 되면서 코드의 양은 줄었지만, 코드의 흐름을 확실히 보기 위해서 말이다. 가독성의 측면에서는 굉장히 예전 코드에 비해선 개선이 많이 되었다.

Operator 활용에 있어서도 기존에 튜토리얼 보다 제한적인 수준에 의존한 느낌이 강해서 UI 인터렉션, 데이터 필터 등 구체적으로 확실하게 쓴 예제들을 참고하여 사용성에 대해서 고민해봐야겠다. 단순한 사용이 아닌 필터, 합성, take 등 고려할 부분을 옵션처럼 활용할 수 있을 때 까지 연습을 더 해봐야할 거 같다. 좋은 기능이 많은데 다 못 쓰는 느낌이 크다.

### 4. 상태 및 데이터 전달 방식에 대한 고민

Delegate, Closure를 통한 Scene 사이에서의 짧은 거리 수준의 전달과 Notification을 통한 긴 거리 수준의 전달에 대한 고민을 항상 하는 것 같다. 이번에는 헤더 부분을 서드 파티에 의존하면서 하다 보니 간단한 데이터 전달에 있어서는 delegate를 활용하였는데 쓰면서 순환 참조를 잘 고려해야할 듯, Delegate를 사용할 때에 항상 AnyObject를 잘 달자! Delegate property는 weak로 선언해야 한다!

### 5. 네트워크 구현 및 API 추상화

RxSwift를 활용하여 비동기 작업을 처리했지만. 서버에서 받아온 데이터는 일반 타입으로 전달하고 해당 스트림에 주입하는 방식으로 현재는 구성해있다. 아무래도 단일 API 호출과 관련하여 가볍게 여기고 작업을 진행한 점이 가장 크지 않을까? 그래서 Moya 등의 서드파티를 사용했을 때가 생각이 났고, 여러 개의 API 호출 시의 쓰레드 관리와 해당 case 관리를 보다 편할 방법을 고민 중이다. 열거형이 아닌 API마다 독립적인 구조체 타입으로 관리하는 방법을 토대로 코드유지 보수가 용이하도록 보완해보는 방식도 나쁘지 않을 듯

### 5. 클린 아키텍쳐

이번 계기로 실제 Robert C. Martin 의 Clean Arichitecture를 읽어보고 swift 형태로 구성된 가장 유명한 [예제 레포](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/tree/master/ExampleMVVM)를 참고 했다. 확실히 고민하던 부분에 대한 해소를 통해서 아키텍쳐 구성에 대한 생각을 많이 했다. Ribs, Viper 등 보다 고단계로 정립된 역할에 대해서도 한 번 튜토리얼을 진행해야할 듯

<img src = "https://user-images.githubusercontent.com/41438361/122946258-2f88ca80-d3b4-11eb-93ba-80b9dbd46818.png" width = "500">

아쉬운 부분은 정말로 Clean 수준의 정도가 어디까지인가? 하는 의문이다. 레이어의 분리와 영역 구성에 있어서 아직은 추상화가 많이 부족하다. 조금 더 데이터 플로우에 대해서 더 깊에 이해하는게 중요한 시점이다.

## ScreenShot
![IMG_C017886C83C0-1](https://user-images.githubusercontent.com/75239459/177031272-ac8138e1-b619-4bf3-be6e-d2d23e0c87c7.png)
