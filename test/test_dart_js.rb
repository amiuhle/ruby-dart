require 'dart_js'
require 'test/unit'
require 'tempfile'

class TestDartJs < Test::Unit::TestCase
  def test_module
    assert_kind_of Module, DartJs
  end

  def test_compile
    Tempfile.open(['test', '.dart']) do |f|
      f.write <<-EOS
        main() {
          print('Hello, Dart!');
        }
      EOS
      f.flush
      DartJs.compile f.path
      assert File.exists?("#{f.path}.js")
    end
  end
end