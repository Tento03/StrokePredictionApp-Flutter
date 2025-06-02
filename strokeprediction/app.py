from flask import Flask, request, jsonify
from flask_cors import CORS
import numpy as np
import joblib

app = Flask(__name__)
CORS(app)  # Mengizinkan semua origin untuk testing. Bisa dibatasi nanti.

# Load model, encoder, dan scaler
model = joblib.load('stroke_model.pkl')
encoder = joblib.load('stroke_encoder.pkl')
scaler = joblib.load('stroke_scaler.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json
        input_data = np.array(data['input']).reshape(1, -1)
        input_data_scaled = scaler.transform(input_data)
        prediction = model.predict(input_data_scaled)
        decoded_prediction = encoder.inverse_transform(prediction)

        return jsonify({
            'prediction': decoded_prediction[0]
        })

    except Exception as e:
        print("Error during prediction:", str(e))  # Tambah log error di console
        return jsonify({
            'prediction': 'error',
            'message': str(e)
        }), 400


if __name__ == '__main__':
    # Agar dapat diakses dari Android device via jaringan lokal
    app.run(host='0.0.0.0', port=5000, debug=True)
