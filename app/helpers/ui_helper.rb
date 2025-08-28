module UiHelper
  def status_badge(status, size: :md)
    key = status.to_s
    color =
      case key
      when "active", "Operational", "resolved" then "badge-green"
      when "down", "Out of Service"            then "badge-red"
      when "maintenance", "in_progress", "monitoring", "planned", "Under Maintenance"
        "badge-yellow"
      else
        "badge-slate"
      end

    content_tag(:span, key.humanize, class: ["badge", color, badge_size_class(size)].join(" "))
  end

  def severity_badge(severity, size: :md)
    key = severity.to_s
    color =
      case key
      when "minor"    then "badge-green"
      when "moderate" then "badge-yellow"
      when "major", "critical" then "badge-red"
      else "badge-slate"
      end

    content_tag(:span, key.humanize, class: ["badge", color, badge_size_class(size)].join(" "))
  end

  private

  def badge_size_class(size)
    case size
    when :sm then "badge-sm"
    when :lg then "badge-lg"
    else ""
    end
  end
end
