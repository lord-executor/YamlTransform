require 'minitest/autorun'
require 'yamltransform/mappingref'
require 'psych'
require 'pp'

class TestGetter < MiniTest::Unit::TestCase

	def setup()
		@data = Psych.parse_file('./test/sample-files/sample-01.yaml').root()
	end

	def test_getter_sequence_ref()
		visitor = YamlTransform::Getter.new("first.second.1")
		visitor.accept(@data)

		assert_equal(1, visitor.result.length)
		assert_kind_of(YamlTransform::SequenceRef, visitor.result.first)
		assert_equal("two", visitor.result.first.value)
	end

	def test_getter_mapping_ref()
		visitor = YamlTransform::Getter.new("first.scalar")
		visitor.accept(@data)

		assert_equal(1, visitor.result.length)
		assert_kind_of(YamlTransform::MappingRef, visitor.result.first)
		assert_equal("some value", visitor.result.first.value)
	end

	def teardown()
	end

end
