class Login {

  String _email;
  String _senha;

  Login(this._email, this._senha);

  Map toJson() {
    return {
      "Email": this._email,
      "Senha": this._senha,
    };
  }

  Map toJsonReclamacao() {
    return {
      "Email": this._email,
      "PasswordHash": this._senha,
    };
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