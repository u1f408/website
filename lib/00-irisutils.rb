module IrisUtils
  def imglink(url, alt: nil)
    url = ERB::Util.html_escape(url)
    alt = ERB::Util.html_escape(alt) if alt

    [
      "<a href=\"#{url}\" class=\"imglink\" target=\"_blank\">",
      "<img src=\"#{url}\" alt=\"#{alt.to_s}\">",
      alt ? "<span class=\"imgalt\">#{alt}</span>" : nil,
      "</a>",
    ].compact.join
  end
end
