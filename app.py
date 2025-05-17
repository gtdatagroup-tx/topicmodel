from flask import Flask, request, jsonify
from bertopic import BERTopic
from sentence_transformers import SentenceTransformer

app = Flask(__name__)
embedding_model = SentenceTransformer("all-MiniLM-L6-v2")
topic_model = BERTopic(embedding_model=embedding_model)

@app.route("/topic-modeling", methods=["POST"])
def model():
    try:
        data = request.get_json(force=True)
        utterances = data.get("utterances", [])

        # Validate input
        if not utterances or not isinstance(utterances, list):
            return jsonify({"error": "utterances must be a non-empty list."}), 400

        # Remove blank or invalid entries
        utterances = [u.strip() for u in utterances if isinstance(u, str) and u.strip()]
        if not utterances:
            return jsonify({"error": "No valid utterances provided."}), 400

        topics, _ = topic_model.fit_transform(utterances)
        result = [topic_model.get_topic(topic)[0][0] for topic in topics]
        return jsonify({"topics": result})

    except Exception as e:
        return jsonify({"error": str(e)}), 500
    if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
