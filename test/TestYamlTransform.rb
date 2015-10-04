require 'minitest/autorun'
require 'yamltransform/transform'
require 'yamltransform/mappingref'
require 'psych'
require 'pp'

class TestYamlTransform < MiniTest::Unit::TestCase

	def setup()
		data = Psych.parse_file('./test/sample-files/sample-01.yaml')
		@transform = YamlTransform::Transform.new(data)
	end

	def test_transform_getter()
		node = @transform.get("first")
		assert_kind_of(YamlTransform::MappingRef, node)
	end

	def test_mapping_ref_key_change()
		node = @transform.get("first")
		assert_equal(node.key, "first")

		node.key = "modified"
		obj = @transform.document.to_ruby()
		refute_nil(obj["modified"])
	end

	def test_append()
		@transform.get("first").append(@transform.from_yaml("new_key: \"new value\""))

		refPrev = @transform.get("first.ultra")
		refNew = @transform.get("first.new_key")
		
		assert_equal(refPrev.keyIndex + 2, refNew.keyIndex)
	end

	def test_prepend()
		@transform.get("first").prepend(@transform.from_yaml("prepended: []"))

		refNext = @transform.get("first.second")
		refNew = @transform.get("first.prepended")
		
		assert_equal(refNext.keyIndex - 2, refNew.keyIndex)
	end

	def teardown()
	end

end
