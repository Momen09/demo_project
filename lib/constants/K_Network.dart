import 'package:flutter/material.dart';

class KNetwork {
  static const photo = 'assets/images/';
  static const token =
      'eyJhbGciOiJSUzI1NiJ9.eyJpZCI6MzAzLCJ0eXBlIjoidXNlciIsInJhbiI6IkJORU5WSVBOTlFUWVB'
      'MS0tVQ0JWIiwic3RhdHVzIjoxfQ.YGV-jGKZj1Lp4SqlM3aiF6Aov6YVF6lZRMpKvx_Zdrpjj4C1zE-J'
      'STKtjVboQ9de58TUViyVOc4JwiktjF_4yxnYzIrw449s584j2GiqUpxfp6OPmfAj8BAbfN_M4RoU5P'
      'XEjhcNVh5uNRtxtvxZtpECrl72_22T4he3LbqISMNHzVh5eprIKIFLt_pM7cyRKt3Njf8I89CLnq5nU'
      'piDHnMMForamKq9jubmiYPOHpFvijEE3-jusRk0F1T32zMY_0AELXnpqhbbx6HtmMdxBahnrUNy'
      'znacdVwaSrNus8vX01N8zEcfRvkRzYuqjnZXr9jrm2iriHq80iicUG99GQ';

  static const locationPhoto = '${photo}dark.png';

  static const mapToken =
      'pk.eyJ1IjoibW9tZW5zYWVlZCIsImEiOiJjbHFqamRrcDUyNmhzMnF0a3ZmaHYzY2s1In0.QqstM0z_f7vuk1jb4zOSLg';

  static const mapUrl =
      'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}';

  static const mapId = 'mapbox/streets-v12';

  static const google_api_key = 'AIzaSyCKfTHmnbKYozxH7WQ6b36s7MBMPdr2i8k';

  static const postUrl = 'http://api.nstack.in/v1/todos';

  static const getUrl = 'http://api.nstack.in/v1/todos?page=1&limit=10';

  static const deleteUrl = 'https://api.nstack.in/v1/todos/65a4f913d4832ba3638a22d6';


}

class SizeScreen {
  BuildContext context;

  SizeScreen(this.context);

  Size get getScreenSize => MediaQuery.of(context).size;
}

class ApiUrl {
  static const apiUrl =
      'https://qa-testing-backend-293b1363694d.herokuapp.com//';
  static const EndPoint =
      'api/v3/mobile-guests/user-events';
}
