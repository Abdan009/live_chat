part of 'pages.dart';

class ListContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AuthEmailServices.signOut();
              Get.offAll(() => LoginPage());
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Center(
                child: Text('Logout'),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Users>>(
          stream: UsersServices.getUserColl(),
          builder: (_, userSnapshot) {
            if (userSnapshot.hasData) {
              List<Users> listUsers = userSnapshot.data;
              // .where((element) => element.id != myUser.id)
              // .toList();
              return StreamBuilder<List<Chat>>(
                stream: ChatServices.getChatColl(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    print('error');
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    List<Chat> listChat = snapshot.data;
                    print(listChat);
                    return ListView(
                      children: [
                        Container(
                          child: Column(
                            children: List.generate(
                              listUsers.length,
                              (index) => Builder(builder: (_) {
                                Chat chat = listChat.firstWhere(
                                  (element) => element.members.contains(
                                    listUsers[index].id,
                                  ),
                                  orElse: () => null,
                                );
                                return ListTile(
                                  onTap: () async {
                                    if (chat == null) {
                                      await ChatServices.updateChat(
                                        Chat(
                                          members: [
                                            myUser.id,
                                            listUsers[index].id,
                                          ],
                                          lastMessage: null,
                                        ),
                                      );
                                    }
                                    Get.to(
                                      () => DetailChatPage(
                                        listUsers[index],
                                        chat: chat,
                                      ),
                                    );
                                  },
                                  title: Text(
                                    listUsers[index].name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    chat?.lastMessage ?? "Belum terdapat chat",
                                    style: TextStyle(fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              listUsers[index].photoProfile,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        backgroundColor: Colors.black,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.yellow),
                      ),
                    );
                  }
                },
              );
            } else {
              print('masuk 2');

              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                ),
              );
            }
          }),
    );
  }
}
