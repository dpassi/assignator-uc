module ApplicationHelper
	def set_title(title = '')
		return "Asignador de Salas" if title.empty?
		return title
	end
end
