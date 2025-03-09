import 'package:flutter_test/flutter_test.dart';
import 'package:repat_event/features/app/app.dart';
import 'package:repat_event/features/counter/presentation/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
