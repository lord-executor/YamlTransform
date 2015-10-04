
require 'psych'
require 'yamltransform/mappingref'
require 'yamltransform/sequenceref'

module YamlTransform

	class Getter < Psych::Visitors::Visitor

		attr_accessor :result

		def initialize(key)
			@segments = key.split('.')
			@next = @segments.shift()
			@result = []
		end

		def visit_Psych_Nodes_Stream(o)
			throw NotImplementedError.new("Getter works only with mapping, sequence and scalar")
		end

		def visit_Psych_Nodes_Document(o)
			throw NotImplementedError.new("Getter works only with mapping, sequence and scalar")
		end

		def visit_Psych_Nodes_Scalar(o)
			throw NotImplementedError.new("nyi")
		end

		def visit_Psych_Nodes_Sequence(o)
			index = @next.to_i()
			if (@segments.empty?())
				@result << SequenceRef.new(o, index)
			else
				recurse(o.children[index])
			end
		end

		def visit_Psych_Nodes_Mapping(o)
			o.children.each_with_index() do |item, index|
				if (index % 2 == 0 && item.value == @next)
					if (@segments.empty?())
						@result << MappingRef.new(o, index)
					else
						recurse(o.children[index + 1])
					end
				end
			end
		end

		def visit_Psych_Nodes_Alias(o)
			throw NotImplementedError.new("Getter works only with mapping, sequence and scalar")
		end

		def recurse(target)
			@next = @segments.shift()
			accept(target)
		end

	end

end
