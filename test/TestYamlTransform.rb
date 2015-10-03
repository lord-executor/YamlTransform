require 'minitest/autorun'
require 'yamltransform/transform'
require 'yamltransform/noderef'
require 'psych'
require 'pp'

class TestYamlTransform < MiniTest::Unit::TestCase

	def setup()
		puts(Dir.pwd)
		data = Psych.parse_file('./test/sample-files/sample-01.yaml')
		@transform = YamlTransform::Transform.new(data)
		refute_nil(@transform)
	end

	def test_hello_world()
		node = @transform.get("")
		assert_kind_of(YamlTransform::NodeRef, node)
	end

end
