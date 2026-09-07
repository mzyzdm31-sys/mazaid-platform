class WalletService {
  // Placeholder service - integrate Stripe/Payment gateway in production

  Future<double> getBalance(String userId) async {
    // Read from Firestore 'wallets' collection in real app
    return 0.0;
  }

  Future<void> topUp(String userId, double amount) async {
    // Trigger Stripe checkout / payment intent in production
  }

  Future<void> holdAmount(String userId, double amount) async {
    // Mark amount as reserved for auction
  }
}
