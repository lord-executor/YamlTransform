require 'minitest/autorun'
require 'yamltransform/transform'
require 'yamltransform/mappingref'
require 'psych'
require 'pp'

class AppendMigration < YamlTransform::Transform

	def execute()

		get("first").append(from_yaml("new_key: \"new value\""))

	end

end

class PrependMigration < YamlTransform::Transform

	def execute()

		get("first").prepend(from_yaml("prepended: []"))

	end

end

class TestYamlTransform < MiniTest::Unit::TestCase

	def setup()
		@data = Psych.parse_file('./test/sample-files/sample-01.yaml')
		@transform = YamlTransform::Transform.new(@data)
	end

	def test_transform_getter()
		
	end

	def test_append_full_yaml_output()
		m = AppendMigration.new(@data)
		m.execute()
		assert_equal(File.read('./test/sample-files/sample-01-append.yaml'), m.to_string())
	end

	def test_prepend_full_yaml_output()
		m = PrependMigration.new(@data)
		m.execute()
		assert_equal(File.read('./test/sample-files/sample-01-prepend.yaml'), m.to_string())
	end

	def teardown()
	end

end
