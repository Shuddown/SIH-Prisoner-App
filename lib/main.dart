import 'package:flutter/material.dart';

void main() => runApp(const LoginApp());

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPrisonerLogin = true;
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> availableLawyers = ['Lawyer 1', 'Lawyer 2', 'Lawyer 3'];
  String selectedLawyer = 'Lawyer 1'; // Default selected lawyer

  void handleLogin() {
    String userId = userIdController.text;
    String password = passwordController.text;

    if (isPrisonerLogin && userId == 'user' && password == 'password') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen(isAdmin: false)),
      );
    } else if (!isPrisonerLogin && userId == 'admin' && password == 'adminpassword') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen(isAdmin: true)),
      );
    } else {
      // Show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid credentials. Please try again.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/law_justice_logo.jpg",
                width: 120.0,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPrisonerLogin = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 24.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Prisoner Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPrisonerLogin = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.admin_panel_settings,
                      size: 24.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Admin Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: isPrisonerLogin
                    ? const Icon(
                        Icons.person,
                        size: 60.0,
                        color: Colors.grey,
                      )
                    : const Icon(
                        Icons.admin_panel_settings,
                        size: 60.0,
                        color: Colors.green,
                      ),
              ),
              const SizedBox(height: 10.0),
              Text(isPrisonerLogin ? 'Prisoner Login' : 'Admin Login'),
              const SizedBox(height: 10.0),
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(
                    hintText: 'Enter ID',
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: handleLogin,
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class WelcomeScreen extends StatelessWidget {
  final bool isAdmin;

  const WelcomeScreen({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Page'),
      ),
      body: WelcomePageContent(isAdmin: isAdmin),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('App Menu'),
            ),
            const Divider(),
            ExpansionTile(
              title: const Text('Legal Assistance Platform'),
              children: [
                const ListTile(
                  title: Text('Get Connected to a Lawyer'),
                ),
                ListTile(
                  title: const Text('Chat with your Lawyer'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Legal Information Platform'),
              children: [
                ListTile(
                  title: const Text('UTP Rights and UTRCs Recommendations'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Add navigation to Connect to Lawyer platform
                  },
                ),
                ListTile(
                  title: const Text('Legal Resources and Guides'),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Add navigation to Chat with Your Lawyer platform
                  },
                ),
              ],
            ),
            if (isAdmin)
              ExpansionTile(
                title: const Text('UTP Status Tracker'),
                children: [
                  ListTile(
                    title: const Text('View Complete Prisoner Information'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Add navigation to UTP Status Tracker platform
                    },
                  ),
                  ListTile(
                    title: const Text('Prisoner Monitoring Portal'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Add navigation to UTP Status Tracker platform
                    },
                  ),
                  ListTile(
                    title: const Text('View Similar Previous Case Histories'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Add navigation to UTP Status Tracker platform
                    },
                  ),
                  // Add more admin-specific features here
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class WelcomePageContent extends StatelessWidget {
  final bool isAdmin;

  const WelcomePageContent({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const <Widget>[
        WelcomePageItem(
          imageAsset: 'assets/welcome_image1.png',
          text: 'Legal Assistance Platform',
        ),
        WelcomePageItem(
          imageAsset: 'assets/welcome_image2.png',
          text: 'Legal Information Platform',
        ),
        // Add more WelcomePageItem widgets for other platforms
      ],
    );
  }
}

class WelcomePageItem extends StatelessWidget {
  final String imageAsset;
  final String text;

  const WelcomePageItem({super.key, required this.imageAsset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          imageAsset,
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage userMessage = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, userMessage);
    });

    // Simulate a reply from the bot after a delay
    Future.delayed(const Duration(seconds: 2), () {
      String botResponse = 'Hello, how can I assist you?';
      ChatMessage botMessage = ChatMessage(
        text: botResponse,
        isUser: false,
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Lawyer'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: const IconThemeData(color: Colors.amber),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: messageAlignment,
        children: <Widget>[
          isUser ? Container() : const CircleAvatar(),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.amberAccent : Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
