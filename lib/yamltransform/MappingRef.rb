
module YamlTransform

	class MappingRef

		attr_accessor :parent, :keyIndex, :valueIndex

		def initialize(parent, keyIndex)
			@parent = parent
			@keyIndex = keyIndex
			@valueIndex = keyIndex + 1
		end

		def key()
			return @parent.children[@keyIndex].value
		end

		def key=(name)
			@parent.children[@keyIndex].value = name
		end

		def append(fragment)
			@parent.children[@valueIndex].children.push(*fragment.children)
		end

		def prepend(fragment)
			@parent.children[@valueIndex].children.unshift(*fragment.children)
		end

	end

end
