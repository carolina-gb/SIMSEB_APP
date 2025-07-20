
import 'config_base.dart';

class ProdEnv extends BaseConfig{
  @override
  String get appName => 'SIMSEB App';

  @override
  String get serviceUrl => 'https://simseb.onrender.com/api';
}


