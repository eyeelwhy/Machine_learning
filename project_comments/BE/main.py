import nltk
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import tensorflow as tf
import pickle
import numpy as np
from pymorphy3 import MorphAnalyzer
from nltk.corpus import stopwords
from keras.preprocessing.sequence import pad_sequences
import pymysql
from datetime import datetime

DB_CONFIG = {
    'host': 'localhost',
    'database': 'db_comments',
    'user': 'root',
    'password': 'Asii2006'
}

morph = MorphAnalyzer()
my_stop_words = ["такой", "это", "всё", "весь"]
stop_words = set(stopwords.words('russian'))
stop_words.update(my_stop_words)


def full_preprocess(text):
    tokens = nltk.word_tokenize(text.lower())
    words = [t.replace('ё', 'е') for t in tokens if t.isalpha()]
    lemmas = [morph.parse(w)[0].normal_form for w in words]
    filtered_lemmas = [l for l in lemmas if l not in stop_words]
    return filtered_lemmas


def save_to_database(text, predictions, is_toxic):
    try:
        connection = pymysql.connect(**DB_CONFIG)
        with connection.cursor() as cursor:
            tone = 'positive' if not is_toxic else 'negative'
            current_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

            cursor.execute(
                "INSERT INTO comments (text, date, tone) VALUES (%s, %s, %s)",
                (text, current_date, tone)
            )
            connection.commit()
            print(f"✅ Saved to DB: {text[:30]}... -> {tone}")
    except Exception as e:
        print(f"❌ DB Error: {e}")
    finally:
        if 'connection' in locals():
            connection.close()


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_methods=["*"],
    allow_headers=["*"],
)

print("Loading model...")
model = tf.keras.models.load_model('lstm_model.h5')
print("✅ Model loaded")

print("Loading tokenizer...")
with open('tokenizer.pickle', 'rb') as f:
    tokenizer = pickle.load(f)
print("✅ Tokenizer loaded")

target_names = ['normal', 'insult', 'threat', 'obscenity']


class TextRequest(BaseModel):
    text: str


@app.post("/predict")
async def predict(request: TextRequest):
    clean_text = full_preprocess(request.text)

    seq = tokenizer.texts_to_sequences([clean_text])
    padded = pad_sequences(seq, maxlen=100)

    pred = model.predict(padded, verbose=0)[0]

    results = {target_names[i]: float(pred[i]) for i in range(len(target_names))}
    is_toxic = any(results[label] > 0.5 for label in target_names if label != 'normal')

    save_to_database(request.text, results, is_toxic)

    return {
        "text": request.text,
        "predictions": results,
        "is_toxic": is_toxic
    }


@app.get("/")
async def root():
    return {"message": "Toxic Comments API is running", "status": "ok"}


@app.get("/test-db")
async def test_db():
    try:
        connection = pymysql.connect(**DB_CONFIG)
        with connection.cursor() as cursor:
            cursor.execute("SELECT COUNT(*) FROM comments")
            count = cursor.fetchone()[0]
        connection.close()
        return {"status": "ok", "comments_count": count}
    except Exception as e:
        return {"status": "error", "message": str(e)}