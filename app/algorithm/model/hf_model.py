
import os
from transformers import pipeline, AutoTokenizer, AutoModelForSequenceClassification

hf_model_path = os.path.join(os.path.dirname(__file__), 'pretrained_model')


def load_model(): 
    
    model = AutoModelForSequenceClassification.from_pretrained(hf_model_path)
    tokenizer = AutoTokenizer.from_pretrained(hf_model_path)
    classifier = pipeline("text-classification", model=model, tokenizer=tokenizer)
    
    print(type(classifier))