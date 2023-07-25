# Docker container for SCALE-MAMBA

SCALE-MAMBA 도커 컨테이너

## Docker Building

command:
```bash
docker build -t <container_image_name>[:<container_image_tag>] -f dockerfile <path>
```

example:
```bash
docker build -t scale-mamba:1.0 -f dockerfile .
```

## Docker container Usage

command:
```bash
docker run --rm -it --name scale-mamba \
-v <host_project_absolute_path>/SCALE-MAMBA:/scale-mamba \
scale-mamba:1.0 <bash_command>
```

example:
```bash
docker run --rm -t --name scale-mamba \
-v 절대경로/SCALE-MAMBA:/scale-mamba \
scale-mamba:1.0 complie.sh Programs/test_fix_array
```

## How to run the project in Docker

Visual Studio Code의 `Dev Containers` 플러그인 사용하여 도커 컨테이너 환겨에서 프로젝트 개발하는 방법이다.

1. `SCALE-MAMBA-docker` repo를 클론받는다.

```bash
git clone https://github.com/link-mozy/SCALE-MAMBA-docker.git
cd SCALE-MAMBA-docker
```

2. `SCALE-MAMBA` repo를 클론받는다.

```bash
git clone https://github.com/KULeuven-COSIC/SCALE-MAMBA.git
```

3. `SCALE-MAMBA-docker` 프로젝트를 VS Code로 연다.

4. `Ctrl / Cmd + Shift + P` 버튼을 누른뒤 `Dev Containers: Rebuild Container and Reopen in Container`를 실행한다.

5. 도커 컨테이너에서 프로젝트 작업을 한다.

> 도커 컨테이너에서 테스트 컴파일 예시:
> ```bash
> cd /scale-mamba
> cp Auto-Test-Data/Cert-Store/* Cert-Store/
> cp Auto-Test-Data/1/* Data/
> ./compile.sh ./Programs/test_fix_array
> ```