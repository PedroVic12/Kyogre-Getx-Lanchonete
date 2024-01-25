from flask import Flask, jsonify, request
from flask_jwt_extended import JWTManager, create_access_token, jwt_required

# JVT
app = Flask(__name__)
app.config['JWT_SECRET_KEY'] = 'seu_jwt_secret'
jwt = JWTManager(app)

#Models
class Usuario:
    def __init__(self, nome, email, senha):
        self.nome = nome
        self.email = email
        self.senha = senha

class Autenticacao:
    def __init__(self):
        self.usuarios = [
            Usuario("Pedro Victor", "pedrovictorveras@id.uff.br", "admin"),
            Usuario("Alex Martins", "alexmartins@example.com", "admin")
        ]

    def validar_usuario(self, email, senha):
        for usuario in self.usuarios:
            if usuario.email == email and usuario.senha == senha:
                return usuario
        return None


# Servidor Web
autenticacao = Autenticacao()

@app.route('/login', methods=['POST'])
def login():
    email = request.json.get('email', None)
    senha = request.json.get('senha', None)
    usuario = autenticacao.validar_usuario(email, senha)

    if usuario:
        access_token = create_access_token(identity=usuario.nome)
        print(f"Usuário {usuario.nome} autenticado com sucesso.")
        return jsonify(access_token=access_token), 200
    else:
        print("Credenciais inválidas.")
        return jsonify({"msg": "Credenciais inválidas"}), 401

if __name__ == '__main__':
    app.run(debug=True)
