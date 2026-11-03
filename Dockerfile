# The PyTorch cu128 wheels ship their own CUDA runtime, so a slim Python base is enough.
# The host only needs a recent NVIDIA driver (and, on Windows, Docker Desktop with the WSL2 backend).
FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /workspace

COPY requirements.txt .
RUN pip install -r requirements.txt

# The project folder is mounted at /workspace at runtime (see README),
# so notebooks, data and results stay on the host.
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

