class Memory {
  static const operations = ['%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? _operation;
  String _value = '0';
  bool _wipeValue = false;
  String? _lastCommand;

  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }
    if (command == 'AC') {
      //Limpar dados;
      _allClear();
    } else if (operations.contains(command)) {
      // Adicionar operação ex(x, +, -, /);
      _setOperation(command);
    } else {
      // Adicionar digitos;
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';
    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }
    _wipeValue = !isEqualSign;
  }

  _addDigit(String digit) {
    // Se valor digitado tem ponto retorna true;
    final isDot = digit == '.';
    // Se valor for igual 0 e não tiver ponto retorna true se não o padrão false;
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;
    // Se wipeValue for true retorna vazio ou o valor;
    // Se tem ponto, e o valor tem mais de um ponto e valor wipeValue é false retorna;
    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }
    // Se tem ponto retorna 0 senão vazio;
    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;

    _wipeValue = false;

    // Tranformar string em double;
    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _allClear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = null;
    _wipeValue = false;
  }

  String get value {
    return _value;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];

      default:
        return _buffer[0];
    }
  }
}
