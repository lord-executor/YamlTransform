
module YamlTransform

	class MappingRef

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
		end

		def prepend(fragment)
		end

	end

end
