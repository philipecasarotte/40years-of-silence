module Admin::PagesHelper

  def show_tree(tree, &block)
  	raise(ArgumentError, "No block given") unless block_given?
    s = ''
    tree.each do |item|
    	s += yield(item, :before)
		  p = item.children
		  if p.length > 0
		  	s += yield(item, :before_children)
	      s += show_tree(p, &block)
		  	s += yield(item, :after_children)
		  end
    	s += yield(item, :after)
    end
    s
  end

  def show_page(page, level = 0)
    s = ""
    s << "<tr>"
    s << "<td>#{"&nbsp;" * 3 * level}#{page.title}</td>"
    s << "<td>#{truncate(strip_tags(page.body), 80)}</td>"
    s << "<td>#{page.permalink}</td>"
    s << "<td>#{link_to 'Show', object_url(page)}</td>"
    s << "<td>#{link_to 'Edit', edit_object_url(page)}</td>"
    s << "<td>#{link_to 'Destroy', object_url(page), :confirm => 'Are you sure?', :method => :delete}</td>"
    s << "</tr>"
    p = page.children
    if p.length > 0
      p.each do |child|
        s += show_page(child, level += 1)
      end
    end
    s
  end
end
