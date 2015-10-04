require 'minitest/autorun'
require 'yamltransform/mappingref'
require 'psych'
require 'pp'

class TestSequence < MiniTest::Unit::TestCase

	def setup()
		@data = Psych.parse_file('./test/sample-files/sample-01.yaml').root()
	end

	def test_sequence_ref_key()
		visitor = YamlTransform::Getter.new("node.0")
		visitor.accept(@data)

		ref = visitor.result.first
		assert_equal(0, ref.key)
	end

	def test_sequence_ref_value_change()
		visitor = YamlTransform::Getter.new("first.second.0")
		visitor.accept(@data)

		ref = visitor.result.first
		assert_equal(0, ref.key)
		assert_equal("one", ref.value)

		ref.value = "modified"
		obj = @data.to_ruby()

		refute_nil(obj['first']['second'])

		sequence = obj['first']['second']
		assert_equal(3, sequence.length)
		assert_equal("modified", sequence[0])
	end

	def teardown()
	end

end
