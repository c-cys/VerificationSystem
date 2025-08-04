from flask import Flask, jsonify
import hello

app = Flask(__name__)

@app.route('/run', methods=['GET'])
def run_code():
    result = hello.run()
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host='localhost', port=5000, debug=True)
