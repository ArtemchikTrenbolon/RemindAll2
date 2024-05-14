import '../entities/entities.dart';

class RepositoryCategory {
  String categoryId;
  String name;
  String icon;
  String color;

  RepositoryCategory({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
  });

  static final empty = RepositoryCategory(
      categoryId: '',
      name: '',
      icon: '',
      color: '',
  );

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      icon: icon,
      color: color,
    );
  }

  static RepositoryCategory fromEntity(CategoryEntity entity) {
    return RepositoryCategory(
      categoryId: entity.categoryId,
      name: entity.name,
      icon: entity.icon,
      color: entity.color,
    );
  }
}