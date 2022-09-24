import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universities/models/university.dart';
import 'package:universities/providers/universities_provider.dart';
import 'package:universities/screens/university_screen.dart';
import 'package:universities/services.dart/university_services.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({ Key? key }) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  List<University> _universities = [];
  bool _isLoading = true;
  final ScrollController scrollController = ScrollController();
  bool _viewList = true;

  @override
  void initState() {
    super.initState();

    _getUniversities();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _getUniversities() async {
    List<University> data = await UniversityServices().getUniversities();
    setState(() {
      _universities = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final universitiesProvider = Provider.of<UniversitiesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Universities'
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _viewList = !_viewList;
            });
          }, 
          icon: _viewList ? const Icon(Icons.grid_on) : const Icon((Icons.list))
        ),
      ),
      body: _isLoading
      ? const Center(
        child: CircularProgressIndicator(),
      )
      : _viewList
      ? _UniversitiesListView(scrollController: scrollController, universities: _universities, universitiesProvider: universitiesProvider)
      : _UniversitiesGridView(universities: _universities, universitiesProvider: universitiesProvider)
    );
  }
}

class _UniversitiesGridView extends StatelessWidget {
  const _UniversitiesGridView({
    Key? key,
    required List<University> universities,
    required this.universitiesProvider,
  }) : _universities = universities, super(key: key);

  final List<University> _universities;
  final UniversitiesProvider universitiesProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: _universities.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 150
        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => 
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.lightBlue,
                width: 2
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: GestureDetector(
              onTap: () {
                universitiesProvider.university = _universities[index];
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const UniversityScreen())
                );
              },
              child: Column(
                children: <Widget>[
                  Text(
                    _universities[index].name,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    _universities[index].country,
                    style: const TextStyle(
                      fontSize: 12
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right),
                ]
              ),
            ),
          )
        ),
    );
  }
}

class _UniversitiesListView extends StatelessWidget {
  const _UniversitiesListView({
    Key? key,
    required this.scrollController,
    required List<University> universities,
    required this.universitiesProvider,
  }) : _universities = universities, super(key: key);

  final ScrollController scrollController;
  final List<University> _universities;
  final UniversitiesProvider universitiesProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      itemCount: _universities.length,
      itemBuilder: (BuildContext context, int index) =>
        ListTile(
          title: Text(
            _universities[index].name
          ),
          subtitle: Text(
            _universities[index].country
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            universitiesProvider.university = _universities[index];
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const UniversityScreen())
            );
          },
        )
    );
  }
}