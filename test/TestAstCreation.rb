require 'minitest/autorun'
require 'yamltransform/transform'
require 'pp'

class TestYamlTransform < MiniTest::Unit::TestCase

	def setup()
		@transform = YamlTransform::Transform.new(Psych::Nodes::Document.new())
	end

	def test_from_ruby()
		node = @transform.from_obj({ :a => "alpha", :b => "beta" })

		assert_kind_of(Psych::Nodes::Mapping, node)
		assert_equal(4, node.children.length)
	end

	def teardown()
	end

end
