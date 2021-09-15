module IrisBreadcrumbs
  def iris_breadcrumb_trail(identifier = nil)
    identifier ||= @item.identifier
    item = @items.find {|i| i.identifier == identifier }
    return [] unless item

    find_breadcrumbs_trail(item.reps[:default].path)
  end

  private
  def find_breadcrumbs_trail(root)
    trail = ["/"]
    root.split("/").each do |s|
      next if s.empty?
      trail << trail.last + "#{s}/"
    end

    trail.map do |segment|
      item = @items.find {|i| i.reps[:default].path == segment}
      next unless item

      {
        item: item,
        path: item.reps[:default].path,
        segment: segment.split("/").compact.last || "/",
        title: item[:title],
      }
    end.compact
  end
end
