
import 'config_base.dart';

class ProdEnv extends BaseConfig{
  @override
  String get appName => 'SIMSEB App';

  @override
  String get serviceUrl => 'http://10.0.2.2:5255/api';
}


