class Registro {

  String _nome;
  String _cpf;
  String _telefone;
  String _usuario;
  String _email;
  String _senha;

  Registro(this._nome, this._cpf, this._telefone, this._usuario, this._email, this._senha);

  Map toJson() {
    return {
      "Nome": this._nome,
      "CPF": this._cpf,
      "Telefone": this._telefone,
      "NomeUsuario": this._usuario,
      "Email": this._email,
      "Senha": this._senha,
    };
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get usuario => _usuario;

  set usuario(String value) {
    _usuario = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

}