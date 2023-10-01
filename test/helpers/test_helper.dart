import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [],
  customMocks: [MockSpec<IOClient>(as: #MockHttpClient)],
)
void main() {}
