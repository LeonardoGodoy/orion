module ApplicationHelper
	def active_tab?(tab)
		params[:controller].eql?(tab)
	end

	def active_tab_class(tab)
	  'active' if active_tab?(tab)
	end
end
