def create_sign_up_form
  file 'app/views/registrations/new.html.erb', <<~SNIPPET_1
<div class="flex flex-col items-center justify-center h-full">
  <h1 class="bg-white mt-10 py-px px-2 -mx-2 uppercase font-bold text-2xl">Sign up</h1>

  <%= form_with model: @user, url: registration_path, :builder => TailwindAuthentication do |form| %>
    <% if @user.errors.any? %>
    <div class="rounded-md bg-red-50 p-4">
      <div class="flex">
        <div class="flex-shrink-0">
          <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3">
          <h3 class="text-sm font-medium text-red-800">
            Fix <%= pluralize(@user.errors.count, "error") %> to complete registration:
          </h3>
          <div class="mt-2 text-sm text-red-700">
            <ul class="list-disc pl-5 space-y-1">
              <% @user.errors.full_messages.each do |message| %>
                <li><%= message %></li>
              <% end %>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <% end %>

    <%= form.email_field :email_address, required: true, autofocus: true, autocomplete: "username", placeholder: "Enter your email address", value: params[:email_address] %>
    <%= form.password_field :password, required: true, autocomplete: "new-password", placeholder: "Enter your password", maxlength: 72 %>
    <%= form.password_field :password_confirmation, required: true, autocomplete: "new-password", placeholder: "Confirm your password", maxlength: 72 %>
    <%= form.submit "Sign up" %>
    <% end %>

  <div class="text-sm text-gray-600 mt-6 flex items-center gap-2">
    <%= link_to "Sign in", new_session_path, class: "text-sm text-gray-600" %>
    <div class="text-gray-600">•</div>
    <%= link_to "Forgot your password?", new_password_path, class: "text-sm text-gray-600" %>
  </div>
</div>
SNIPPET_1

end

def add_sign_up_link_to_sign_in_form
  inject_into_file 'app/views/sessions/new.html.erb',
  <<~SNIPPET_2,
<%= link_to "Sign up", new_registration_path, class: "text-sm text-gray-600" %>
  <div class="text-gray-600">•</div>
SNIPPET_2
before: '<%= link_to "Forgot your password?", new_password_path'
end

create_sign_up_form
add_sign_up_link_to_sign_in_form