part of 'pages.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              SignInSignOutResult result =
                  await AuthEmailServices.signInWithGoogle();
              if (result.user != null) {
                print('Login Sukses');
                Get.offAll(
                  () => ListContactPage(),
                );
              } else {
                print(result.message);
              }
            },
            child: Text('Login')),
      ),
    );
  }
}
