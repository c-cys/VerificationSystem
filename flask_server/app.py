
from flask import Flask, send_file, jsonify
import predict

app = Flask(__name__)

@app.route('/run', methods=['GET'])
def run_code():
    detection, _ = predict.run()
    return jsonify({
        'detection': detection,
        'image_url': 'http://localhost:5000/image'
    })

@app.route('/image')
def get_image():
    _, result_path = predict.run()
    return send_file(result_path)

if __name__ == '__main__':
    app.run(host='localhost', port=5000, debug=True)