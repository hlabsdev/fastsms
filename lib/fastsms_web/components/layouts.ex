defmodule FastsmsWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use FastsmsWeb, :controller` and
  `use FastsmsWeb, :live_view`.
  """
  use FastsmsWeb, :html

  embed_templates "layouts/*"

  attr :name, :string, default: "FastSMS"
  def logo(assigns) do
    ~H"""
      <img src={~p"/images/logo.svg"} width="80" />
      <p class="bg-brand/5 text-brand rounded-full px-2 font-medium leading-6">
        v<%= Application.spec(:fastsms, :vsn) %>
      </p>
    """
  end

#  slot :logo
#  slot :link, default: [%{__slot__: :link, inner_block: nil, label: "Dashboard", to: "/"}]
#  def navbar(assigns) do
#    ~H"""
#    <nav class="bg-white border-gray-200 px-2 sm:px-4 py-2.5 rounded dark:bg-gray-900">
#      <div class="container flex flex-wrap items-center justify-between mx-auto">
#        <%= render_slot(@logo) %>
#        <button phx-click={toggle_dropdown("#navbar-default")} type="button" class="inline-flex items-center p-2 ml-3 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
#          <span class="sr-only">Open main menu</span>
#          <svg class="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
#        </button>
#        <div class="hidden w-full md:block md:w-auto" id="navbar-default">
#          <ul class="flex flex-col p-4 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:text-sm md:font-medium md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
#            <%= for link <- @link do %>
#              <.link navigate={link.to} class="block py-2 pl-3 pr-4 text-gray-700 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-gray-400 md:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">
#                <%= link.label %>
#              </.link>
#            <% end %>
#          </ul>
#        </div>
#      </div>
#    </nav>
#    """
#  end

    slot :logo
    slot :link, default: [%{__slot__: :sub_links, inner_block: nil, label: "Dashboard", to: "/"}]
  def navbar(assigns) do
    ~H"""
    <nav class="bg-white border-gray-200 px-2 sm:px-4 py-2.5 rounded dark:bg-gray-900">
      <div class="container flex flex-wrap items-center justify-between mx-auto">
        <%= render_slot(@logo) %>
        <button phx-click={toggle_dropdown("#navbar-default")} type="button" class="inline-flex items-center p-2 ml-3 text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-default" aria-expanded="false">
          <span class="sr-only">Open main menu</span>
          <svg class="w-6 h-6" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"></path></svg>
        </button>
        <div class="hidden w-full md:block md:w-auto" id="navbar-default">
          <ul class="flex flex-col p-4 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:text-sm md:font-medium md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
            <%= for link <- @link do %>
              <li class="relative group">
                <%= if Map.has_key?(link, :to) and link.to != nil do %>
                  <.link navigate={link.to} class="block py-2 pl-3 pr-4 text-gray-700 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-gray-400 md:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">
                    <%= link.label %>
                  </.link>
                <% else %>
                  <span class="block py-2 pl-3 pr-4 text-gray-700 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 dark:text-gray-400 md:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent">
                    <%= link.label %>
                  </span>
                <% end %>
                <%= if Map.has_key?(link, :sub_links) and link.sub_links != nil do %>
                  <ul class="absolute left-0 hidden mt-2 space-y-2 bg-white border border-gray-200 rounded-lg shadow-lg group-hover:block dark:bg-gray-800 dark:border-gray-700">
                    <%= for sub_link <- link.sub_links do %>
                      <li>
                        <.link navigate={sub_link.to} class="block px-4 py-2 text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-700">
                          <%= sub_link.label %>
                        </.link>
                      </li>
                    <% end %>
                  </ul>
                <% end %>
              </li>
            <% end %>
          </ul>
        </div>
      </div>
    </nav>
    """
  end


  defp toggle_dropdown(id, js \\ %JS{}) do
    js
    |> JS.toggle(to: id)
  end
end
