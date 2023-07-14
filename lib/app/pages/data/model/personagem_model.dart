class PersonagemModel {
  final int id;
  final String name;
  final String species;
  final String image;

  PersonagemModel({
    required this.id,
    required this.name,
    required this.species,
    required this.image,
  });

  factory PersonagemModel.fromMap(Map<String, dynamic> map) {
    return PersonagemModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      species: map['species'] ?? '',
      image: map['image'] ?? '',
    );
  }
}