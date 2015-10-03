
require 'yamltransform/noderef'

module YamlTransform

	class Transform

		def initialize(document)
			@document = document
		end

		def get(key)
			parent = @document.root()
			node = parent
			i = 0

			key.split('.').each() do |segment|
				puts("processing #{segment}")
				i = node.children.index() { |item| item.value == segment }
				puts("index #{i}")
				if (i != nil)
					parent = node
					node = node.children[i + 1]
				end
			end

			return NodeRef.new(parent, i)
		end

		def delete(key)
		end

	end

end