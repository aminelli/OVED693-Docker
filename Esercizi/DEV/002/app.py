from flask import Flask, jsonify, request
from datetime import datetime
import os

app = Flask(__name__)

# Configurazione
PORT = int(os.environ.get('PORT', 5000))

# Route principale
@app.route('/')
def home():
    return jsonify({
        'message': 'Benvenuto nell\'applicazione Python Flask!',
        'timestamp': datetime.now().isoformat(),
        'version': '1.0.0'
    })

# Route di esempio - Lista prodotti
@app.route('/api/products')
def get_products():
    products = [
        {'id': 1, 'name': 'Laptop', 'price': 999.99, 'category': 'Electronics'},
        {'id': 2, 'name': 'Mouse', 'price': 29.99, 'category': 'Electronics'},
        {'id': 3, 'name': 'Keyboard', 'price': 79.99, 'category': 'Electronics'},
        {'id': 4, 'name': 'Monitor', 'price': 299.99, 'category': 'Electronics'}
    ]
    return jsonify(products)

# Route di esempio - Singolo prodotto
@app.route('/api/products/<int:product_id>')
def get_product(product_id):
    products = {
        1: {'id': 1, 'name': 'Laptop', 'price': 999.99, 'category': 'Electronics'},
        2: {'id': 2, 'name': 'Mouse', 'price': 29.99, 'category': 'Electronics'},
        3: {'id': 3, 'name': 'Keyboard', 'price': 79.99, 'category': 'Electronics'},
        4: {'id': 4, 'name': 'Monitor', 'price': 299.99, 'category': 'Electronics'}
    }
    
    product = products.get(product_id)
    if product:
        return jsonify(product)
    else:
        return jsonify({'error': 'Prodotto non trovato'}), 404

# Route di esempio - POST
@app.route('/api/echo', methods=['POST'])
def echo():
    data = request.get_json()
    return jsonify({
        'message': 'Echo ricevuto',
        'data': data,
        'timestamp': datetime.now().isoformat()
    })

# Route informazioni sistema
@app.route('/api/info')
def get_info():
    import sys
    import platform
    
    return jsonify({
        'python_version': sys.version,
        'platform': platform.platform(),
        'processor': platform.processor(),
        'flask_env': os.environ.get('FLASK_ENV', 'production')
    })

# Health check
@app.route('/health')
def health_check():
    return jsonify({
        'status': 'OK',
        'timestamp': datetime.now().isoformat()
    }), 200

# Route per calcoli matematici
@app.route('/api/calculate')
def calculate():
    try:
        num1 = float(request.args.get('num1', 0))
        num2 = float(request.args.get('num2', 0))
        operation = request.args.get('op', 'add')
        
        operations = {
            'add': num1 + num2,
            'sub': num1 - num2,
            'mul': num1 * num2,
            'div': num1 / num2 if num2 != 0 else 'Errore: divisione per zero'
        }
        
        result = operations.get(operation, 'Operazione non valida')
        
        return jsonify({
            'num1': num1,
            'num2': num2,
            'operation': operation,
            'result': result
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 400

# Error handler 404
@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Route non trovata'}), 404

# Error handler 500
@app.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Errore interno del server'}), 500

if __name__ == '__main__':
    print(f'Server Flask in esecuzione sulla porta {PORT}')
    print(f'Ambiente: {os.environ.get("FLASK_ENV", "production")}')
    app.run(host='0.0.0.0', port=PORT, debug=False)

