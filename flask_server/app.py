<<<<<<< HEAD
from flask import Flask, send_file, jsonify
import predict
=======
from flask import Flask, jsonify
import hello
>>>>>>> 997aa603fb96247d7c7c4984c294c885563ef2f5

app = Flask(__name__)

@app.route('/run', methods=['GET'])
def run_code():
<<<<<<< HEAD
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
=======
    result = hello.run()
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host='localhost', port=5000, debug=True)
>>>>>>> 997aa603fb96247d7c7c4984c294c885563ef2f5
