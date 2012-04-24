
class Document

	def initialize(root, title)
		@root = root
		@title = title
		@description = nil
		@author = nil
		@chapters = Array.new
	end
	attr_accessor :root
	attr_accessor :titel
	attr_accessor :description
	attr_accessor :author
	attr_accessor :chapters

end

class Chapter

	def initialize(parent, title)
		@parent = parent
		@title = title
		@chapters = Array.new
		@pages = Array.new
	end
	attr_accessor :parent
	attr_accessor :title
	attr_accessor :chapters
	attr_accessor :pages

end

class Page

	def initialize(parent, title)
		@parent = parent
		@title = title
		@tags = Hash.new
	end
	attr_accessor :parent
	attr_accessor :title
	attr_accessor :tags

end