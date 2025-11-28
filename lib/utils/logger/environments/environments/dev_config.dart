import 'base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiHost =>
      'https://diann-tenantable-lianne.ngrok-free.dev';
      //'https://ad11b58a66e5.ngrok-free.app';
     // 'http://192.168.29.195:8000';

  // String get apiHost => 'http://192.168.2.55:3010/';

  @override
  String get path => 'frontend-apis/';


  @override
  String get awsPath => 'aws-bucket/';
  @override
  String get serviceProvider => 'service-provider-apis';
}


