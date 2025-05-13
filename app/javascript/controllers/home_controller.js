import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["formContainer", "input", "linkContainer", "providerGithub", "providerGithub_data_residency", "providerGithub_data_residency-button"]

  connect() {
    this.formContainerTarget.hidden = true
    this.providerGithub_data_residencyTarget.disabled = true
    this.providerGithub_data_residencyTarget.hidden = true
    
    console.log("home controller connected")
  }

  showForm() {
    this.formContainerTarget.hidden = false
    this.linkContainerTarget.hidden = true
    this.providerGithubTarget.hidden = true
    this.providerGithub_data_residencyTarget.hidden = false
  }

  check() {
    const subdomain = this.getValue()?.trim() ?? ""; // Returns "" if null and trims whitespace
    if (this.validValue(subdomain)) {
      this.providerGithub_data_residencyTarget.disabled = false
      this.reconstructUrl(subdomain)
    } else {
      this.providerGithub_data_residencyTarget.disabled = true
    }
  }

  reconstructUrl(subdomain) {
    const baseUrl = this.providerGithub_data_residencyTarget.dataset.enterpriseTargetUrl
    const finalUrl = `${baseUrl}?enterprise_subdomain=${encodeURIComponent(subdomain)}`
    this.providerGithub_data_residencyTarget.setAttribute("formaction", finalUrl)
    this.providerGithub_data_residencyTarget.setAttribute("formmethod", "post")
  }

  getValue() {
    return this.inputTarget.value || null
  }

  validValue(subdomain) {
    // Regex to match valid subdomain characters (letters, numbers, hyphens, but not starting with a hyphen)
    // https://regex101.com/r/2A1cLa/1
    const subdomain_regex = /^\w[\w-]+\w$/
    return subdomain !== null && subdomain.length > 0 && subdomain_regex.test(subdomain)
  }
}
