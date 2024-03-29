import 'package:http/http.dart' as http;

void fetchData() async {
  const String url = 'https://moviesdatabase.p.rapidapi.com/titles/x/upcoming';
  final Map<String, String> headers = {
    'X-RapidAPI-Key': '7786f90c70msh921a76a3839a3e0p1a7ce7jsnc8b7cda04a74',
    'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      // Ovdje možete obraditi odgovor API-ja, npr. parsirati JSON podatke
    } else {
      print('Greška prilikom slanja zahteva: ${response.statusCode}');
    }
  } catch (error) {
    print('Greška prilikom slanja zahteva: $error');
  }
}