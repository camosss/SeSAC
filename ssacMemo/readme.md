
### 진행 상황


<img src = "https://user-images.githubusercontent.com/93528918/141433307-9f005873-b08a-4b57-bef9-187ee8872637.png" width="50%" height="50%">


‼️ 남은 기능 ‼️
- 고정된 메모 다섯개 이상이면 토스트 띄우기
- 검색한 키워드 텍스트 컬러 변경
- 메모 수정해서 업데이트
     

---
     
### 1. 최초 팝업 화면

`앱 처음 실행 때 팝업화면 띄우기 (최초 1회만 뜨고, 이후에는 뜨지 않음)`

https://user-images.githubusercontent.com/93528918/141428626-3e270931-6eab-4628-8912-8577d70a7a6c.mov

https://user-images.githubusercontent.com/93528918/141428630-e8ff0260-132b-4a3d-ad05-6434e5558f74.mov

  
---

### 2. 메모 추가

-  타이틀: 저장된 메모 수로 띄우기 (1,000개 넘으면 콤마 추가) [NumberFormatter]

<img src = "https://user-images.githubusercontent.com/93528918/141432455-31b240c7-6f0e-43e9-af86-0bee1f226b0a.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/93528918/141432465-93b4103d-85d9-4f57-9420-4757a57518c7.png" width="30%" height="30%">


- 리턴키를 입력하기 전까지 제목, 나머지는 내용으로 저장
- 메모 추가 (add 뷰 들어가면 키보드 자동으로 올리기, 키보드 내려가지 않음)
- 메모 추가 완료하고 메인 뷰로 넘어가기 (백버튼 눌러도 메모 저장됨, 아무내용 없으면 저장x)
- 최신순 정렬
- 날짜 포맷 형태 (전체, 이번주, 오늘)



https://user-images.githubusercontent.com/93528918/141428891-ffc1bf9b-0c18-45a4-b52b-35ff8e92b381.mov

https://user-images.githubusercontent.com/93528918/141428895-7ff6708e-cbf7-4818-bd2d-208a597a2c95.mov


---

### 3. Swipe

`swipe (Leading Swipe - 고정, Trailing Swipe - 삭제)`

- 고정된 메모가 없으면 섹션 없애기
- 삭제할 때 확인 알림

https://user-images.githubusercontent.com/93528918/141429291-dfb2dd9b-d9c6-4413-968f-ca9b3f2db252.mov

https://user-images.githubusercontent.com/93528918/141429293-84513224-8b71-4a5f-a5cc-ec45933f5cbb.mov


---

### 4. 검색

- 메모를 실시간 검색
- 검색 결과 갯수는 섹션헤더에 표시
- 검색 결과를 스크롤 하거나 키보드의 검색 버튼을 누르면 키보드가 내려감



https://user-images.githubusercontent.com/93528918/141432767-e6ee7e36-5823-4375-b101-f77dac17dc13.mov


https://user-images.githubusercontent.com/93528918/141432769-4c5c4dd2-f568-4531-ab8c-dd0e47c660b4.mov


---

### 5. 작성, 수정화면, 공유

- 셀을 클릭하면 수정 화면으로 (add 뷰) (해당 메모 들어가면 내용 그대로 수정할 수 있게)
- 우측 상단 공유 버튼을 클릭하면 메모 텍스트가 UIActivityViewController를 통해 공유
- 수정화면에서는 TextView를 클릭해서 편집상태가 되면, Bar버튼(공유, 완료)이 나타남


https://user-images.githubusercontent.com/93528918/141430328-2466e54d-a18c-4984-a5fb-b574698fc060.mov



https://user-images.githubusercontent.com/93528918/141430337-fa1ae156-174b-4a2c-b40f-5c433dc319bb.mov








