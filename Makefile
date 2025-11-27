### Makefile ###

# Tuist manifests 실행
.PHONY: edit
edit:
	@echo "\033[32mTuist manifests 실행합니다...🛠️\033[0m"
	tuist edit

# Tuist 의존성 설치
.PHONY: install
install:
	@echo "\033[32mTuist install를 실행합니다...🛠️\033[0m"
	@echo "\033[32m의존성 설치 중...\033[0m"
	tuist install

.PHONY: cache
cache:
	TUIST_ROOT_DIR=${PWD} tuist cache ${target} --external-only

# Tuist 프로젝트 생성 및 열기
.PHONY: generate
generate:
	@echo "\033[32mTuist generate를 실행합니다.\033[0m"
	TUIST_ROOT_DIR=${PWD} TUIST_BUILD_CONFIG=${config} tuist generate ${target}

# 템플릿으로 만들어둔 모듈 생성
.PHONY: scaffold
scaffold:
	tuist scaffold Framework --layer ${layer} --name ${name}

.PHONY: clean
clean:
	tuist clean
	@rm -rf *.xcworkspace
	@find Projects -name "*.xcodeproj" -exec rm -rf {} \;

.PHONY: project_start
project_start:
	@echo "\033[32m프로젝트 작업을 시작합니다...\033[0m"
	make install
	@echo "\033[32m프로젝트 캐싱 작업을 진행합니다...\033[0m"
	make cache
	@echo "\033[32m프로젝트를 생성합니다...\033[0m"
	make generate

.PHONY: dev
dev:
	@echo "\033[32mdev 환경 빌드를 시작합니다...\033[0m"
	make install
	make cache
	make generate config=dev

.PHONY: release
release:
	@echo "\033[32mrelease 환경 빌드를 시작합니다...\033[0m"
	make install
	make cache
	make generate config=release

.PHONY: beta
beta:
	@echo "\033[32mbeta 환경 빌드를 시작합니다...\033[0m"
	make install
	make cache
	make generate config=release

.PHONY: graph
graph:
	@echo "\033[32mTuist 의존성 관련 그래프를 작성 중입니다...📈\033[0m"
	tuist graph
