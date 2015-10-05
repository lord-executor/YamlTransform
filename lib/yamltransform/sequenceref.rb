
module YamlTransform

	class SequenceRef

		attr_accessor :parent, :index

		def initialize(parent, index)
			@parent = parent
			@index = index
		end

		def key()
			return @index
		end

		def value()
			return @parent.children[@index].value
		end

		def value=(scalar)
			@parent.children[@index].value = scalar
		end

		def append(fragment)
			@parent.children[@index].children.push(*fragment.children)
		end

		def prepend(fragment)
			@parent.children[@index].children.unshift(*fragment.children)
		end

		def replace()
		end

		def copy_to()
		end

	end

end
