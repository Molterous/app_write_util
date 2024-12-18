import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'helpers.dart';
import 'constants.dart';

class AppWriteUtil {

  /// setup

  static const _tag = 'AppWriteUtil';

  // The single instance of the class
  static final AppWriteUtil _instance = AppWriteUtil._privateConstructor();

  // Public getter to access the instance
  static AppWriteUtil get instance => _instance;

  // Private constructor
  AppWriteUtil._privateConstructor();


  /// variables

  // client variable
  Client? _client;

  // client getter
  Client getClient() {

    if (_client == null) throw Exception('init not called');

    return _client!;
  }


  // account variable
  Account? _account;

  // account getter
  Account getAccount() {

    if (_account == null) throw Exception('account is null');

    return _account!;
  }

  // _currentUser variable
  User? _currentUser;

  // user getter
  User getUser() {

    if (_currentUser == null) throw Exception('current user is null');

    return _currentUser!;
  }


  /// functions

  Future<void> init() async {
    _client = Client();

    _client!.setEndpoint(Strings.appWriteUrl)
        // todo remove this
        .setProject('67556a78003293408500')
        .setSelfSigned();

    _account = Account(getClient());

    await _fetchUserDetails();
  }


  Future<void> _fetchUserDetails() async {

    try {

      final user = await getAccount().get();
      _currentUser = user;

    } catch (e) {
      printHelper(_tag, 'user is logged out');
    }

    printHelper(_tag, 'user is logged in');
  }


  Future<User> createUser({
    required String name,
    required String email,
    required String password,
  }) async {

    try {
      final user = await getAccount().create(
        userId    : ID.unique(),
        email     : email,
        password  : password,
        name      : name,
      );

      printHelper(_tag, 'user created successfully');
      return user;

    } catch (e) {
      printHelper(_tag, 'user creation failed: ${e.toString()}');
      rethrow;
    }
  }


  Future<Session> createEmailSession({
    required String email,
    required String password,
  }) async {

    try {
      final session = await getAccount()
          .createEmailPasswordSession(email: email, password: password);

      _currentUser = await getAccount().get();

      printHelper(_tag, 'user session creation passed');
      return session;

    } catch (e) {
      printHelper(_tag, 'user session creation failed: ${e.toString()}');
      rethrow;
    }
  }


  Future<Session> signInWithProvider({required OAuthProvider provider}) async {
    try {
      final session = await getAccount()
          .createOAuth2Session(provider: provider);

      _currentUser = await getAccount().get();

      printHelper(_tag, 'signInWithProvider passed');
      return session;

    } catch (e) {
      printHelper(_tag, 'signInWithProvider failed: ${e.toString()}');
      rethrow;
    }
  }


  Future<void> signOut() async {
    try {
      await getAccount().deleteSession(sessionId: 'current');
      printHelper(_tag, 'sign Out done');

    } catch (e) {
      printHelper(_tag, 'sign Out failed: ${e.toString()}');
      rethrow;
    }
  }
}