from flask import Flask, request, jsonify
from bertopic import BERTopic
from sentence_transformers import SentenceTransformer

app = Flask(__name__)
embedding_model = SentenceTransformer("nlpaueb/legal-bert-base-uncased")
topic_model = BERTopic(embedding_model=embedding_model)

@app.route("/topic-modeling", methods=["POST"])
def model():
    data = request.get_json()
    utterances = data.get("utterances", [])
    if not utterances:
        return jsonify({"error": "No utterances provided"}), 400

    topics, _ = topic_model.fit_transform(utterances)
    result = [topic_model.get_topic(topic)[0][0] for topic in topics]
    return jsonify({"topics": result})
