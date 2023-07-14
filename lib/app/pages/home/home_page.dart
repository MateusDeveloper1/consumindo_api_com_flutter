import 'package:flutter/material.dart';
import 'package:project_api/app/pages/data/http/http_client.dart';
import 'package:project_api/app/pages/data/repositories/personagem_repository.dart';
import 'package:project_api/app/pages/home/store/store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonagemStore store = PersonagemStore(
    repository: PersonagemRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    store.getPersonagem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Consumindo API",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff41a232),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff41a232),
              Color(0xff212121),
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            store.isloading,
            store.state,
            store.erro,
          ]),
          builder: (context, child) {
            if (store.isloading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Text(
                  store.erro.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              );
            }

            if (store.state.value.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum Personagem a ser mostrado',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 32),
                padding: const EdgeInsets.all(16),
                itemCount: store.state.value.length,
                itemBuilder: (context, index) {
                  final item = store.state.value[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Image.network(item.image),
                              ),
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(item.species),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
