def update_sign_in
  prepend_to_file 'app/views/sessions/new.html.erb', <<~SNIPPET_1
<div class="flex flex-col items-center justify-center h-full">
  <h1 class="bg-white mt-10 py-px px-2 -mx-2 uppercase font-bold text-2xl">Sign in</h1>
SNIPPET_1

  gsub_file 'app/views/sessions/new.html.erb', "<%= form_with url: session_path do |form| %>", "<%= form_with url: session_path, :builder => TailwindAuthentication do |form| %>"
  append_to_file 'app/views/sessions/new.html.erb', <<~SNIPPET_4
<div class="mt-6 text-sm text-gray-600 flex items-center gap-2">
    <%= link_to "Forgot your password?", new_password_path %>
  </div>
</div>
SNIPPET_4

  gsub_file 'app/views/sessions/new.html.erb', '<%= link_to "Forgot password?", new_password_path %>', ''
  gsub_file 'app/views/sessions/new.html.erb', '<br>',''
end

def update_forgot_your_password
  gsub_file 'app/views/passwords/new.html.erb', "<h1>Forgot your password?</h1>", ''
  prepend_to_file 'app/views/passwords/new.html.erb', <<~SNIPPET_7
<div class="flex flex-col items-center justify-center h-full">
  <h1 class="bg-white mt-10 py-px px-2 -mx-2 uppercase font-bold text-2xl">Forgot your password?</h1>
SNIPPET_7

  gsub_file 'app/views/passwords/new.html.erb', "<%= form_with url: passwords_path do |form| %>", "<%= form_with url: passwords_path, :builder => TailwindAuthentication do |form| %>"
  append_to_file 'app/views/passwords/new.html.erb', '</div>'
end

update_sign_in
update_forgot_your_password