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
docker run -it --name scale-mamba \
-v <host_project_absolute_path>/Cert-Store:/scale-mamba/Cert-Store \
-v <host_project_absolute_path>/Data:/scale-mamba/Data \
-v <host_project_absolute_path>/Progarams:/scale-mamba/Programs \
scale-mamba:1.0 bash
```

## How to run the project in Docker

1. `SCALE-MAMBA-docker` repo를 클론받는다.

```bash
git clone https://github.com/link-mozy/SCALE-MAMBA-docker.git
```

2. `SCALE-MAMBA` repo를 클론받는다.

```bash
git clone https://github.com/KULeuven-COSIC/SCALE-MAMBA.git
```

3. `SCALE-MAMBA-docker` 프로젝트를 VS Code로 연다.

4. `Ctrl / Cmd + Shift + P` 버튼을 누른뒤 `Dev Containers: Rebuild Container and Reopen in Container`를 실행한다.

5. 도커 컨테이너에서 프로젝트 작업을 한다.

> 도커 컨테이너에서 테스트 컴파일 예시:

```bash
cd SCALE-MAMBA
cp Auto-Test-Data/Cert-Store/* Cert-Store/
cp Auto-Test-Data/1/* Data/
./compile.sh ./Programs/test_fix_array
```