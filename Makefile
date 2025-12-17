.PHONY: setup install train merge ollama-create help

SHELL := /bin/bash
PROJECT_DIR := $(shell pwd)
VENV_NAME := .venv

help: ## Show help
	@echo "Makefile commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s - %s\n", $$1, $$2}'

setup: ## Setup the development environment
	uv venv $(VENV_NAME) --python python3.12
	uv sync

install: ## Install dependencies
	uv sync

train: ## Train the LoRA
	uv run train.py

merge: ## Merge LoRA into base model
	uv run merge_lora.py

ollama-create: ## Create Ollama model
	@echo "Creating Ollama model..."
	@if [ ! -d "llama.cpp" ]; then \
		echo "Cloning llama.cpp..."; \
		git clone https://github.com/ggerganov/llama.cpp; \
	fi
	. $(VENV_NAME)/bin/activate && cd llama.cpp && python convert_hf_to_gguf.py \
		../merged_model \
		--outfile merged_model.gguf \
		--outtype q8_0
	mv llama.cpp/merged_model.gguf ./ollama-model/
	cd ollama-model && ollama create html-extract -f Modelfile