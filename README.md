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