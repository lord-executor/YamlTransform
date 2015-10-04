require 'minitest/autorun'
require 'yamltransform/transform'
require 'pp'

class TestYamlTransform < MiniTest::Unit::TestCase

	def setup()
		@transform = YamlTransform::Transform.new(Psych::Nodes::Document.new())
	end

	def test_from_ruby_string()
		node = @transform.from_obj("some string")

		assert_kind_of(Psych::Nodes::Scalar, node)
		assert_equal("some string", node.value)
	end

	def test_from_ruby_number()
		node = @transform.from_obj(666)

		assert_kind_of(Psych::Nodes::Scalar, node)
		assert_equal("666", node.value)
	end

	def test_from_ruby_hash()
		node = @transform.from_obj({ :a => "alpha", :b => "beta" })

		assert_kind_of(Psych::Nodes::Mapping, node)
		assert_equal(4, node.children.length)
	end

	def test_from_yaml_string()
		node = @transform.from_yaml("random text")

		assert_kind_of(Psych::Nodes::Scalar, node)
		assert_equal("random text", node.value)
	end

	def test_from_yaml_mapping()
		node = @transform.from_yaml("first: 1\nsecond: 2")

		assert_kind_of(Psych::Nodes::Mapping, node)
		assert_equal(4, node.children.length)
		assert_equal("first", node.children[0].value)
		assert_equal("1", node.children[1].value)
	end

	def test_from_yaml_sequence()
		node = @transform.from_yaml("- first\n- second")

		assert_kind_of(Psych::Nodes::Sequence, node)
		assert_equal(2, node.children.length)
		assert_equal("first", node.children[0].value)
		assert_equal("second", node.children[1].value)
	end

	def teardown()
	end

end
