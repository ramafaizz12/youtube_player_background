part of 'pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController texinput = TextEditingController();

  SetBackgroundCubit yturl = SetBackgroundCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: red,
      appBar: AppBar(
        backgroundColor: abuabu,
        title: Text(
          "Youtube Player",
          style: textpoppins,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, p1) => Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: p1.maxWidth * 0.03,
                right: p1.maxWidth * 0.03,
                top: p1.maxHeight * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: p1.maxWidth,
                  height: p1.maxHeight * 0.1,
                  decoration: BoxDecoration(
                      color: abuabu, borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: texinput,
                      style: textpoppins.copyWith(
                          color: black, fontSize: p1.maxWidth * 0.05),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: black,
                          ),
                          hintText: "Masukkan Link Youtube",
                          hintStyle: textpoppins.copyWith(
                              color: black, fontSize: p1.maxWidth * 0.03),
                          isDense: true,
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 5),
                          border: InputBorder.none),
                      onChanged: (value) {
                        context.read<AudioCubit>().setUrl(url: value);
                        yturl.getVideoid(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: p1.maxHeight * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YoutubePage(
                            id: yturl.state,
                          ),
                        ));
                  },
                  child: Container(
                    width: p1.maxWidth * 0.4,
                    height: p1.maxHeight * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: abuabu,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 5,
                            offset: const Offset(2, 4))
                      ],
                    ),
                    child: LayoutBuilder(
                      builder: (p0, p1) => Center(
                        child: Text(
                          "Cari",
                          textAlign: TextAlign.center,
                          style: textpoppins.copyWith(
                              fontSize: p1.maxWidth * 0.09, color: black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
