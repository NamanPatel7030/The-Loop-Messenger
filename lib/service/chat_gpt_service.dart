import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String apiKey = "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"; // Replace with your actual API key

  Future<String> sendMessage(String message) async {
    const String url = "https://api.openai.com/v1/chat/completions";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo", // Or the appropriate model you are using
          "messages": [
            {"role": "user", "content": message}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return "Error: ${response.statusCode} ${response.reasonPhrase}";
      }
    } catch (e) {
      return "An error occurred: $e";
    }
  }
}
