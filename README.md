## Cellular-Network

### Cellular Network Topology

#### 기지국 배치
- 시뮬레이션에서 기지국을 배치하기 위해 기준 셀의 기지국을 직교 좌표계의 원점에 위치시킴
- 정해진 셀 반경에 대해 인접 셀들의 기지국 위치를 계산해서 결정 
- 이때 기지국은 전방향성 안테나가 부착되었다고 가정하고 각 셀의 중앙에 위치 배치
- 기준 셀을 중심으로 나머지 1-티어의 6셀과 2-티어의 12셀의 기지국 위치를 계산하여 출력

<img src="https://user-images.githubusercontent.com/58179712/129134496-f1238bca-bab8-4169-8ff0-86de11886a94.png"  width="400">

#### 단말 배치
- 단말의 위치가 기지국을 중심으로 무작위로 설정됨을 확인
<img src="https://user-images.githubusercontent.com/58179712/129134531-a2afa74e-0675-4f22-80de-47921f630a51.png"  width="400">

### Channel Model Simulation

#### Path Loss
- Path Loss란 송신기와 수신기 사이의 통신 경로 상에서 신호의 전력이 감소하는 것을 의미
- 자유 공간에서의 Path Loss에 대해 고려
- 자유 공간 모델에서 채널에는 LoS (Line of Sight) 신호만 존재
- 이 경우 신호의 감쇄는 거리의 제곱에 비례함
<img src="https://user-images.githubusercontent.com/58179712/129134586-517f7438-e54c-400f-a223-4d43628e6d5f.png"  width="400">

#### Shadowing
- Shadowing은 신호가 전파할 때 건물, 나무 등의 장애물에 의해 발생하는 음영 효과로 인한 전파 손실
- 음영 효과에는 흡수, 차단, 감쇠, 굴절 등의 현상이 발생
- 음영 손실은 신호가 전파시 장애물을 만날 경우 전파 장애물 바로 뒤에 전파적인 그림자가 드리워져 나타나는 전파 손실
- 위의 Path Loss만 있는 환경에 Shadowing의 영향을 추가

<img src="https://user-images.githubusercontent.com/58179712/129134603-3d817787-4abf-4ee8-8620-ce1871392a1f.png"  width="400">
<img src="https://user-images.githubusercontent.com/58179712/129134614-76be4032-4320-454f-94f0-b5ce62a36a68.png"  width="400">

#### Multipath Fading
- 송신 신호는 여러 물체에 의한 다중 반사로 인해 서로 다른 Path를 따라 전파 가능
- Multipath Fading은 다중 반사로 인해 서로 다른 진폭, 위상, 시간 지연에 의해 신호 간에 간섭이 발생하여 수신시 신호의 강도가 변화
- Multipath Fading은 서로 다른 경로를 따라 수신된 전파들이 여러 물체에 의한 다중 반사 등으로 인해, 서로다른 진폭, 위상, 입사각, 편파 등이 간섭을 일으켜 불규칙하게 요동치는 현상
- 위의 Path Loss+Shadowing 모델에 Multipath Fading을 추가
- 시뮬레이션을 통해 신호의 감쇄를 일으키는 크게 세 가지 요인, Path Loss, Shadowing, 그리고 Multipath Fading의 영향을 알아보고 그 중 Small Scale Fading인 Multipath Fading의 영향이 가장 심하다는 것을 알게 됨

<img src="https://user-images.githubusercontent.com/58179712/129134554-a584dba8-6a4a-45be-82b2-73eb5d9be054.png"  width="400">
<img src="https://user-images.githubusercontent.com/58179712/129134570-d32eb52d-f1b8-44a8-9850-c1b22bf4718e.png"  width="400">
