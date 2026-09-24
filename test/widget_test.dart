import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cardvault/main.dart';

void main() {
  testWidgets('CardVault app loads to the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CardVaultApp()));

    expect(find.text('CardVault Login'), findsOneWidget);
  });
}
