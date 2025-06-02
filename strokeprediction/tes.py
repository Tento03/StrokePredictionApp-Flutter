from flask import Flask,request,jsonify
import joblib
import numpy as np

app=Flask(__name__)

model=joblib.load('stroke_model.pkl')
scaler=joblib.load('stroke_scaler.pkl')
decoder=joblib.load('stroke_encoder.pkl')

@app.route('/predict',methods=['POST'])
def predict():
    try:
        data=request.json
        input_user=np.array(data['input']).reshape(1,-1)
        input_user_scaled=scaler.transform(input_user)
        predict=model.predict(input_user_scaled)
        decoded_predict=decoder.inverse_transform(predict)

        return jsonify({
            'predss':decoded_predict[0]
        })
    except Exception as e:
        return jsonify({
            'msg':str(e)
        })
    
if __name__ == '__main__':
    app.run(debug=True)