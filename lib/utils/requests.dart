import 'package:http/http.dart' as http;

Future<http.Response> delete(url, token) async {
  var client = http.Client();

  var response = await client.delete(
    url,
    headers: {
      "authorization": "Bearer $token",
    },
  );

  return response;
}

Future<http.Response> getReq(Uri url, String token) async {
  var client = http.Client();

  var response = await client.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "authorization": (token != null) ? "Bearer $token" : "",
    },
  );

  return response;
}

Future<http.Response> post(Uri url, String token, data) async {
  var client = http.Client();

  var response = await client.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "authorization": (token != null) ? "Bearer $token" : "",
    },
    body: data,
  );

  return response;
}

Future<http.Response> put(Uri url, String token, data) async {
  var client = http.Client();

  var response = await client.put(
    url,
    headers: {
      "Content-Type": "application/json",
      "authorization": (token != null) ? "Bearer $token" : "",
    },
    body: data,
  );

  return response;
}