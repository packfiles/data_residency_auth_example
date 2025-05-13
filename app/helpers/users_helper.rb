module UsersHelper
  def pretty_print_provider_name(provider_name)
    case provider_name
    when "github"
      "GitHub.com"
    when "githubdr"
      "GitHub Enterprise Cloud with Data Residency"
    end
  end
end
