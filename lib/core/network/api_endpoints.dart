class ApiEndpoints {
  const ApiEndpoints._();

  static const login = '/auth/login';
  static const logout = '/auth/logout';
  static const session = '/auth/session';

  static const cards = '/cards';

  static String card(String cardId) => '/cards/$cardId';

  static String cardLimits(String cardId) => '/cards/$cardId/limits';

  static String cardReveal(String cardId) => '/cards/$cardId/reveal';

  static String cardCredit(String cardId) => '/cards/$cardId/credit';

  static String cardStatements(String cardId) => '/cards/$cardId/statements';

  static String cardStatement(String cardId, String month) =>
      '/cards/$cardId/statements/$month';

  static String cardPayment(String cardId) => '/cards/$cardId/pay';

  static String cardBlock(String cardId) => '/cards/$cardId/block';
}
