module ApplicationHelper
  
  #エラーメッセージカスタマイズ用
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    # エラーメッセージ用のHTMLを生成
    messages = resource.errors.full_messages.each do |message|
      html += <<-EOF
        <ul class="error_explanation">
          <li class="alert alert-error">#{message}</li>
        </ul>
      EOF
    end
    html.html_safe
  end
end
