generate :controller, 'Home', 'index', '--skip-routes'

file 'app/views/home/index.html.erb', <<~SNIPPET_1,
<div class="flex flex-col items-center justify-center h-screen gap-4 w-full">
  <h1 class="text-primary text-4xl font-bold">There's no place like 127.0.0.1:3000</h1>
  <%= button_to "Logout", session_path, method: :delete, class: "px-4 mt-4 py-2 bg-red-500 text-white rounded hover:bg-red-600" %>
</div>
SNIPPET_1
force: true

route('root to: "home#index"')