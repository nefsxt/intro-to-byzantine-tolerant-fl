# Introduction to Byzantine Fault Tolerance in Federated Learning

This notebook is an introduction to Byzantine fault tolerance in Federated Learning (FL), built around a simplified maritime scenario: several coast guards and maritime agencies want to train a shared ship detector on satellite imagery they cannot pool, so they federate. Before getting to Byzantine robustness, the notebook covers the key theoretical aspects of FL: the federated objective, the FedAvg algorithm, and IID vs non-IID clients, from both an experimental and an optimization (client drift) perspective.

It is a deliberately simplified example (a small public dataset, a small CNN, and 10 clients simulated on a single machine), meant to demonstrate the key concepts on a use case that is close to real scenarios.

## Work in Progress

This project is a work in progress. Content, experiments and results may be altered or extended in future updates.

**Completed**
- Dataset loading, class imbalance and train/test split
- Federated Learning foundations: centralized vs federated training, FedAvg, IID vs non-IID (Dirichlet) partitioning
- An optimization perspective on IID vs non-IID data and client drift, with a 2D toy example
- No-attack experiments: FedAvg on IID vs non-IID clients against a centralized baseline, and the effect of local epochs on client drift

**Next**
- Rerun of the client-drift experiment with a more skewed non-IID split (lower α)
- The Byzantine threat model
- A label-flipping attack (compromised stations relabeling ships as open ocean)
- Krum as a Byzantine-robust defense, on IID and non-IID clients
- How the fraction of Byzantine clients affects each aggregation rule

## Sister Project

This is the sister project of [Adversarially Robust CNN for CIFAR-10](https://github.com/nefsxt/adversarially-robust-cnn-cifar10). Basics such as CNN layers, DataLoaders and the standard training loop are explained there and only briefly recapped here. 

## Data

The notebook uses the [Ships in Satellite Imagery](https://www.kaggle.com/datasets/rhammell/ships-in-satellite-imagery) dataset (rhammell, Kaggle), with imagery by [Planet](https://www.planet.com/): 4000 RGB image chips of 80x80 pixels, labeled ship / no-ship.

- The dataset is licensed under **CC BY-SA 4.0** and is **not included** in this repository.
- On the first run, the notebook downloads it to `./data` with `kagglehub`. If the automatic download fails, download it from the Kaggle page and place `shipsnet.json` in `./data/`.


## How to Run

### Requirements
- An NVIDIA GPU
- The dataset is downloaded automatically to `./data` on the first run (see [Data](#data))

### Option 1: Docker (recommended)
Requires Docker with GPU support (NVIDIA Container Toolkit, or Docker Desktop with WSL 2 on Windows).

1. Build the image from the project folder:
   ```bash
   docker build -t byzantine_fl-env .
   ```
2. Start the container (PowerShell, from the project folder):
   ```bash
   docker run --gpus all -it -p 127.0.0.1:8888:8888 -v "${PWD}:/workspace" byzantine_fl-env
   ```
3. Open the link printed in the terminal (`http://127.0.0.1:8888/lab?token=...`), open `byzantine_fl.ipynb` and run the cells from top to bottom.

The image installs PyTorch built with CUDA 12.8 (needed for RTX 50-series GPUs). For older GPUs, a different PyTorch build may be required.

### Option 2: Local Python environment
1. Install the dependencies (Python 3.12). `requirements.txt` installs PyTorch built with CUDA 12.8; for a different CUDA version, first install PyTorch for your system (see https://pytorch.org/get-started/locally/) and remove the `torch` line from `requirements.txt`.
   ```bash
   pip install -r requirements.txt
   ```
2. Start Jupyter Lab and run `byzantine_fl.ipynb` from top to bottom:
   ```bash
   jupyter lab
   ```

### Cached results
Each experiment saves its results, together with the configuration that produced them, to `./results`. Re-running the notebook loads these results instead of retraining. To retrain from scratch, set `rerun=True` in the `Config` dataclass.

## License

Copyright © 2026 Nefeli Eleftheria Sextou. All rights reserved. See [LICENSE](LICENSE) for details.

The dataset, the cited publications and the third-party software used in this project are not covered by this license and remain under their own terms (see [LICENSE](LICENSE)).
