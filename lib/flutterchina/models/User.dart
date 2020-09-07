import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'User.g.dart';

/*
flutter clean
flutter pub cache repair
flutter pub run build_runner clean
 */
///flutter packages pub run build_runner build
///flutter packages pub run build_runner build --delete-conflicting-outputs
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User{
  User(this.name, this.email);

  String name;
  String email;

  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}