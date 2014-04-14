class ApplicationController < ActionController::Base
  after_filter :set_access_control_headers

  # respond to options requests with blank text/plain as per spec
  def cors_preflight_check
    logger.info ">>> responding to CORS request"
    render :text => '', :content_type => 'text/plain'
  end

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = '*' 
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*' 
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  before_action :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_tld || extract_locale_from_subdomain || extract_locale_from_accept_language_header || I18n.default_locale
  end
  
  protected
  
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  end
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    if parsed_locale
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    else
      return nil
    end
  end
  def extract_locale_from_accept_language_header
    http_accept_language.compatible_language_from(I18n.available_locales)
  end

  def after_sign_in_path_for(resource)
    new_website_path
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
