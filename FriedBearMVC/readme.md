# 곰튀김님 유투브 학습 내용 정리
## [도대체 어떻게 하는 것이 MVVM 인것이냐? 오늘 결론 내립니다.](https://www.youtube.com/watch?v=M58LqynqQHc&t=796s)
### 실습내용 
#### MVC -> MVVM -> MVVM Rx
## 용어정리
1. Entity : 서버에서 사용하는 모델
2. Model : 앱 로직에서 사용하기 위한 모델
3. viewModel : 화면에 뿌려주기 위한 모델
## Data Flow in MVVM
> 1. Server Data -> Repostitory -> Entity(서버모델) Repository를 사용해 서버에서 사용하는 데이터를 JsonDecode로 Entity에 매핑 
> 2. Repository -> Service -> Model(로직용 모델) Entity를 앱에서 사용하는 부분만 가져와 비지니스 로직에서 사용하는 모델 -> MOdel로 변경
> 3. Service -> ViewModel -> ViewModel 뷰에서 사용자에게 보여주기 위한 데이터로 모델을 변경 -> ViewModel

<img width="80%" src="https://github.com/didwns7347/RxStudy/issues/1#issue-1499447890"/>
