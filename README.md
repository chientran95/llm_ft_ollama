This repository is to demonstrate LoRA finetuning of LLM and convert to use in Ollama

## Data

Download data from this [file](https://drive.google.com/file/d/1HEaB_VNuAoqM-ywS-aa5KZiaPSzHzUeX/view?usp=sharing)

## Overview

Requirement: Install [uv](https://docs.astral.sh/uv/getting-started/installation/)

1. Train the LoRA: `make train`
2. Merge the trained LoRA to create full model: `make merge`
3. Create ollama usable model: `make ollama-create`
4. Final model **html-extract** can be seen with `ollama list` and use with `ollama run html-extract`

## Reference
[YouTube video](https://www.youtube.com/watch?v=pTaSDVz0gok)

