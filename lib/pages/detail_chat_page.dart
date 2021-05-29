part of 'pages.dart';

class DetailChatPage extends StatefulWidget {
  final Users user;
  final Chat chat;
  DetailChatPage(
    this.user, {
    this.chat,
  });

  @override
  _DetailChatPageState createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder<List<DetailChat>>(
            stream: DetailChatServices.getChatDetailColl(widget.chat.id),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('error');
                print(snapshot.error);
              }
              if (snapshot.hasData) {
                List<DetailChat> listChat = snapshot.data;
                listChat.sort(
                  (a, b) => a.timeCreate.compareTo(b.timeCreate),
                );
                return (listChat.isNotEmpty)
                    ? Container(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Column(
                                children: List.generate(
                                  listChat.length,
                                  (index) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          (listChat[index].sendId == myUser.id)
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            listChat[index].message,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Text('Belum terdapat Chat'),
                        ),
                      );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, -1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (messageController.text.trim() != "") {
                        DetailChat detailChat = DetailChat(
                          sendId: myUser.id,
                          message: messageController.text,
                          timeCreate: DateTime.now(),
                        );
                        DetailChatServices.updateChat(
                            detailChat, widget.chat.id);
                        ChatServices.updateChat(
                          widget.chat.copyWith(
                            lastMessage: messageController.text,
                          ),
                        );
                        messageController.text = "";
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
