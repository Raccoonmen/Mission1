# 제로베이스 백엔드 스쿨 12기 Mission1
- 작성자 제로베이스 백엔드 스쿨 12기 마스터반 나엽


## 프로젝트 목적

내 위치를 기반으로 공공 와이파이 정보를 제공하는 웹 서비스 개발입니다.
서울시 오픈API을 활용해서 DB에 API 데이터를 관리하고, 타 시스템 호출 (Open API) 기능을 구현합니다.


## 설치 및 실행 방법

1. Eclipse를 사용합니다.
2. 프로젝트를 클론하거나 압축 파일을 다운로드합니다.
3. 명령 프롬프트 또는 터미널에서 프로젝트 디렉토리로 이동합니다.
4. 프로젝트를 실행합니다.


## 주요 기능

- 서울시 오픈API를 이용해서 서울시의 와이파이 정보를 가져올 수 있습니다.
- 내 위치의 위도와 경도를 호출할 수 있습니다.
- 원하는 위도와 경도를 이용해서 내 위치에 가까운 20개의 와이파이 항목을 가져옵니다.
- 검색한 위도와 경도의 히스토리 내역이 남습니다.
- 북마크 추가기능이 존재합니다.


## 사용 라이브러리

- okhttp3 3.12.1
- gson 2.9.0
- sqlite-jdbc-3.36.0.3


## 어플리케이션 서버

- Apache Tomcat v8.5

