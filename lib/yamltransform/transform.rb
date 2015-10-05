
require 'yamltransform/mappingref'
require 'yamltransform/getter'
require 'psych'

module YamlTransform

	class Transform

		attr_accessor :document

		def initialize(document)
			@document = document
		end

		def execute()
		end

		def get(key)
			getter = Getter.new(key)
			getter.accept(@document.root())

			return getter.result.first
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

		def from_obj(obj)
			return Psych.parse_stream(Psych.dump(obj)).children.first.root()
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
