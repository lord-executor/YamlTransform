require 'minitest/autorun'
require 'yamltransform/mappingref'
require 'psych'
require 'pp'

class TestMappingRef < MiniTest::Unit::TestCase

	def setup()
		@data = Psych.parse_file('./test/sample-files/sample-01.yaml').root()
	end

	def test_mapping_ref_key_change()
		visitor = YamlTransform::Getter.new("first.second")
		visitor.accept(@data)

		ref = visitor.result.first
		assert_equal("second", ref.key)

		ref.key = "modified"
		obj = @data.to_ruby()

		assert_nil(obj["first"]["second"])
		refute_nil(obj["first"]["modified"])
		assert_equal(["one", "two", "three"], obj["first"]["modified"])
	end

	def test_mapping_value_change()
		visitor = YamlTransform::Getter.new("node.0.start")
		visitor.accept(@data)

		ref = visitor.result.first
		assert_equal("start", ref.key)
		assert_equal("0", ref.value)

		ref.value = "12"
		obj = @data.to_ruby()

		assert_equal(12, obj["node"][0]["start"])
	end

	def teardown()
	end

end
