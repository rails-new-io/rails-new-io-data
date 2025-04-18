def create_sign_up_form
  file 'app/views/registrations/new.html.erb', <<~SNIPPET_1
<div class="mx-auto md:w-2/3 w-full">
  <% if alert = flash[:alert] %>
    <p class="py-2 px-3 bg-red-50 mb-5 text-red-500 font-medium rounded-lg inline-block" id="alert"><%= alert %></p>
  <% end %>
  <% if notice = flash[:notice] %>
    <p class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block" id="notice"><%= notice %></p>
  <% end %>
  <h1 class="font-bold text-4xl">Sign up</h1>
  <%= form_with model: @user, url: registration_url, class: "contents" do |form| %>
    <div class="my-5">
      <%= form.email_field :email_address, required: true, autofocus: true, autocomplete: "username", placeholder: "Enter your email address", value: params.dig(:user, :email_address), class: "block shadow-sm rounded-md border border-gray-400 focus:outline-blue-600 px-3 py-2 mt-2 w-full" %>
    </div>
    <div class="my-5">
      <%= form.password_field :password, required: true, autocomplete: "new-password", placeholder: "Enter your password", maxlength: 72, class: "block shadow-sm rounded-md border border-gray-400 focus:outline-blue-600 px-3 py-2 mt-2 w-full" %>
    </div>
    <div class="my-5">
      <%= form.password_field :password_confirmation, required: true, autocomplete: "new-password", placeholder: "Confirm your password", maxlength: 72, class: "block shadow-sm rounded-md border border-gray-400 focus:outline-blue-600 px-3 py-2 mt-2 w-full" %>
    </div>
    <div class="col-span-6 sm:flex sm:items-center sm:gap-4">
      <div class="inline">
        <%= form.submit "Sign up", class: "w-full sm:w-auto text-center rounded-md px-3.5 py-2.5 bg-blue-600 hover:bg-blue-500 text-white inline-block font-medium cursor-pointer" %>
      </div>
      <div class="mt-4 text-sm text-gray-500 sm:mt-0">
        <%= link_to "Already have an account? Sign in", new_session_path, class: "text-gray-700 underline hover:no-underline" %>
      </div>
    </div>
  <% end %>
</div>
SNIPPET_1

end

def add_sign_up_link_to_sign_in_form
  inject_into_file 'app/views/sessions/new.html.erb',
  <<~SNIPPET_2,
<div class="mt-4 text-sm text-gray-500 sm:mt-0">
  <%= link_to "Sign up", new_registration_path, class: "text-gray-700 underline hover:no-underline" %>
</div>
<div class="text-gray-600">•</div>

SNIPPET_2
before: /\s+<div class="[^"]*">\s+<%= link_to "Forgot/mi
end

create_sign_up_form
add_sign_up_link_to_sign_in_form