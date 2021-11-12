
### 진행 상황


<img src = "https://user-images.githubusercontent.com/93528918/141511900-43a69b8c-f523-4e37-b1b1-cddab48a27ef.png" width="70%" height="70%">
 
‼️ ***헷갈리는 부분***

- `이번주 작성한 메모는 일요일, 화요일 과 같은 형태로 표현합니다.` → 현재 날짜를 기준으로 이번주임을 고려하는 코드의 불확실성
- 메모를 저장할 때, 내용이 `nil` 이면 "추가 텍스트 없음"으로 따로 저장했는데, 검색을 했을 때 해당 문자열을 어떻게 고려하는지 (SearchBar에 "추가 텍스트 없음"을 고려하지 않는 법,,)


---
     
### 1. 최초 팝업 화면

`앱 처음 실행 때 팝업화면 띄우기 (최초 1회만 뜨고, 이후에는 뜨지 않음)`

https://user-images.githubusercontent.com/93528918/141428626-3e270931-6eab-4628-8912-8577d70a7a6c.mov

https://user-images.githubusercontent.com/93528918/141428630-e8ff0260-132b-4a3d-ad05-6434e5558f74.mov

  
---
### 2. 메모 리스트 화면

-  타이틀: 저장된 메모 수로 띄우기 (1,000개 넘으면 콤마 추가) [NumberFormatter]

<img src = "https://user-images.githubusercontent.com/93528918/141432455-31b240c7-6f0e-43e9-af86-0bee1f226b0a.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/93528918/141432465-93b4103d-85d9-4f57-9420-4757a57518c7.png" width="30%" height="30%">


- 최신순 정렬
- 날짜 포맷 형태 (오늘, 이번주, 그외)


👉  ***고정된 목록에 추가***
 


- 고정된 메모가 없으면 섹션 없애기
- 다섯개 이상이면 토스트 띄우기


👉 ***스와이프***
 

- Leading Swipe - 고정, Trailing Swipe - 삭제
- Leading Swipe를 통해 메모가 고정되거나 해제 (이미지 변경)
- 삭제할 때 확인 알림


https://user-images.githubusercontent.com/93528918/141512316-617d6103-0ac7-4a9a-b0a4-8e93c2691084.mov

https://user-images.githubusercontent.com/93528918/141512325-d55920fc-ff55-409a-8046-0a8a54d93e6c.mov


---

### 3. 검색

👉 ***메모를 실시간 검색***
 

- 검색 결과 갯수는 섹션헤더에 표시
- 검색 결과를 스크롤 하거나 키보드의 검색 버튼을 누르면 키보드가 내려간다.
- 검색한 키워드 텍스트 컬러 변경
- 셀을 클릭하면 메모 수정 화면으로 전환


https://user-images.githubusercontent.com/93528918/141512411-d79af294-8442-4f42-a9f7-0dc4d5ec619e.mov

https://user-images.githubusercontent.com/93528918/141512435-c4c65eca-6fc8-4bd7-83ea-18f139591176.mov



---

### 4. 작성/수정 화면

- 텍스트뷰에 작성한 텍스트가 두 개의 컬럼에 나눠 저장
- 작성/수정 기능을 한 화면에 함께 구현
- 작성 화면 진입 시, 키보드 자동으로 올리기
- 우측 상단 공유 버튼을 클릭하면 메모 텍스트가 UIActivityViewController를 통해 공유


https://user-images.githubusercontent.com/93528918/141512510-b0e9e510-e968-4288-a8b4-efc943a29d2c.mov


https://user-images.githubusercontent.com/93528918/141512513-549aeb71-ea47-4ae7-be8c-8f1e69f77d1d.mov


---

### 5. 편집

- 셀을 클릭하면 수정 화면으로 (add 뷰) (해당 메모 들어가면 내용 그대로 수정할 수 있게)
- 수정화면에서는 TextView를 클릭해서 편집상태가 되면, Bar버튼(공유, 완료)이 나타남


https://user-images.githubusercontent.com/93528918/141512569-0df040f2-0003-4fa3-a2b9-95eaa46e7d46.mov


https://user-images.githubusercontent.com/93528918/141512574-005ef391-9531-4e18-b492-498d22b4c4ae.mov




