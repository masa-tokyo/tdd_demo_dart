import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/main.dart';

//--------------------------------------------------
// 記述順番：１
// APIのレスポンス→(User)のデータ変換処理のシナリオ（テストコード作成）
//--------------------------------------------------

void main() {
  //--------------------------------------------------
  // Userドメインモデルのテスト
  //--------------------------------------------------
  group('User domain test', () {
    test('ageは0以上', () {
      expect(() => User('john', -1, 'john@example.com'), throwsArgumentError);
    });

    test('nameは1文字以上', () {
      expect(() => User('', 10, 'john@example.com'), throwsArgumentError);
    });

    test('emailは1文字以上', () {
      expect(() => User('John', 10, ''), throwsArgumentError);
    });
  });

  //--------------------------------------------------
  // APIレスポンスのテスト
  //--------------------------------------------------
  group('Translate API request test', () {
    test('APIのレスポンスをドメインモデルに変換する', () {
      Map<String, dynamic> apiResponseJson = {
        'name': 'john',
        'age': 25,
        'email': 'john@example.com'
      };

      final response = UserApiResponse(apiResponseJson);
      UserResponseTranslator translator = UserResponseTranslator();
      User user = translator.translate(response);

      expect(user.name, equals('john'));
      expect(user.age, equals(25));
      expect(user.email, equals('john@example.com'));
    });
  });
}

/// ドメインモデル。
class User {
  final String name;
  final int age;
  final String email;

  User(this.name, this.age, this.email) {
    if (name.isEmpty) {
      throw ArgumentError('name は 1文字以上');
    }
    if (age < 0) {
      throw ArgumentError('age は 0以上');
    }
    if (email.isEmpty) {
      throw ArgumentError('email は 1文字以上');
    }
  }
}

/// 疑似API レスポンス。
class UserApiResponse {
  final String name;
  final int age;
  final String email;

  UserApiResponse(Map<String, dynamic> json)
      : name = '',
        age = 0,
        email = '' {
    throw UnimplementedError();
  }
}

/// APIレスポンスからドメインモデルに変換するトランスレーター。
abstract interface class DataTranslator<TSource, TTarget> {
  TTarget translate(TSource source);
}

class UserResponseTranslator implements DataTranslator<UserApiResponse, User> {
  @override
  User translate(UserApiResponse source) {
    throw UnimplementedError();
  }
}
