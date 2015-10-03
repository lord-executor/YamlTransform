
module YamlTransform

	class NodeRef

		def initialize(parent, keyIndex)
			@parent = parent
			@keyIndex = keyIndex
			@valueIndex = keyIndex + 1
		end

		def append(fragment)
		end

		def prepend(fragment)
		end

	end

end
