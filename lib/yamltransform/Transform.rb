
require 'yamltransform/mappingref'
require 'psych'

module YamlTransform

	class Transform

		attr_accessor :document

		def initialize(document)
			@document = document
		end

		def get(key)
			parent = @document.root()
			node = parent
			i = 0

			key.split('.').each() do |segment|
				i = node.children.index() { |item| item.is_a?(Psych::Nodes::Scalar) && item.value == segment }
				if (i != nil)
					parent = node
					node = node.children[i + 1]
				end
			end

			return MappingRef.new(parent, i)
		end

		def grep(key)
		end

		def find(key, value)
		end

		def delete(key)
		end

		def from_yaml(string)
			return Psych.parse_stream(string).children.first.root()
		end

		def to_string()
			stream = Psych::Nodes::Stream.new()
			stream.children << @document

			return stream.to_yaml(nil, { :indentation => 4, :canonical => false })
		end

		def to_ruby()
			return @document.to_ruby()
		end

	end

end
