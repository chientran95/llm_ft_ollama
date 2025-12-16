from unsloth import FastLanguageModel
from peft import PeftModel
import torch

base_model = "unsloth/Phi-3-mini-4k-instruct-bnb-4bit"   # MUST match training
adapter_dir = "./lora_output"

model, tokenizer = FastLanguageModel.from_pretrained(
    model_name = base_model,
    load_in_4bit = False,      # IMPORTANT: must be False to merge
    dtype = torch.float16,
    device_map = "auto",
)

model = PeftModel.from_pretrained(model, adapter_dir)

# 🔥 Merge LoRA into base model
model = model.merge_and_unload()

# Save FULL merged model (HF format)
model.save_pretrained("merged_model", safe_serialization=True)
tokenizer.save_pretrained("merged_model")
