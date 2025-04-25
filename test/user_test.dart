import 'package:flutter_test/flutter_test.dart';

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

      UserApiResponse response = UserApiResponse(apiResponseJson);
      UserResponseTranslator translator = UserResponseTranslator();
      User user = translator.translate(response);

      expect(user.name, equals('john'));
      expect(user.age, equals(25));
      expect(user.email, equals('john@example.com'));
    });
  });
}
