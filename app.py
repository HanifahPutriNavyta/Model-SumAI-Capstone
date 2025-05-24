from fastapi import FastAPI
from pydantic import BaseModel
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM
import torch

# Inisialisasi FastAPI
app = FastAPI()

# Deteksi device (GPU jika tersedia)
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# Load model dan tokenizer
model_name = "hanifahputri/Capstone-Model-SumAI"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForSeq2SeqLM.from_pretrained(model_name).to(device)

# Schema untuk input menggunakan Pydantic
class SummarizationRequest(BaseModel):
    text: str

# Endpoint untuk summarization
@app.post("/summarize")
def summarize(request: SummarizationRequest):
    text = request.text
    inputs = tokenizer.encode("summarize: " + text, return_tensors="pt", max_length=512, truncation=True).to(device)
    outputs = model.generate(
        inputs,
        max_length=150,
        min_length=30,
        length_penalty=2.0,
        num_beams=4,
        early_stopping=True
    )
    summary = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return {"summary": summary}

