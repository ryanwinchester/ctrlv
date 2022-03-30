defmodule CtrlvWeb.PasteLive.SideBarComponent do
  use CtrlvWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->
      <div class="fixed inset-0 flex z-40 lg:hidden" role="dialog" aria-modal="true">
        <!--
          Off-canvas menu overlay, show/hide based on off-canvas menu state.

          Entering: "transition-opacity ease-linear duration-300"
            From: "opacity-0"
            To: "opacity-100"
          Leaving: "transition-opacity ease-linear duration-300"
            From: "opacity-100"
            To: "opacity-0"
        -->
        <div class="fixed inset-0 bg-gray-600 bg-opacity-75" aria-hidden="true"></div>

        <!--
          Off-canvas menu, show/hide based on off-canvas menu state.

          Entering: "transition ease-in-out duration-300 transform"
            From: "-translate-x-full"
            To: "translate-x-0"
          Leaving: "transition ease-in-out duration-300 transform"
            From: "translate-x-0"
            To: "-translate-x-full"
        -->
        <div class="relative flex-1 flex flex-col max-w-xs w-full pt-5 pb-4 bg-gray-700">
          <!--
            Close button, show/hide based on off-canvas menu state.

            Entering: "ease-in-out duration-300"
              From: "opacity-0"
              To: "opacity-100"
            Leaving: "ease-in-out duration-300"
              From: "opacity-100"
              To: "opacity-0"
          -->
          <div class="absolute top-0 left-0 -ml-12 pt-2">
            <button type="button" class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
              <span class="sr-only">Close sidebar</span>
              <!-- Heroicon name: outline/x -->
              <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <div class="flex-shrink-0 flex items-center px-4">
            <span class="text-white text-2xl font-bold leading-7">
              <span class="kbd border border-neutral-focus border-opacity-20 bg-base-200 px-2 rounded-btn">ctrl</span>
              <span class="kbd border border-neutral-focus border-opacity-20 bg-base-200 px-2 rounded-btn">v</span>
              <span class="kbd border border-neutral-focus border-opacity-20 bg-black px-2 rounded-btn">.io</span>
            </span>
          </div>
          <nav class="mt-5 flex-shrink-0 h-full divide-y divide-gray-800 overflow-y-auto" aria-label="Sidebar">
            <div class="px-2 space-y-1">
              <!-- Current: "bg-gray-800 text-white", Default: "text-gray-100 hover:text-white hover:bg-gray-600" -->
              <a href="#" class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" aria-current="page">
                <!-- Heroicon name: outline/save -->
                <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"></path>
                </svg>
                Save
              </a>

              <%= if @is_editing do %>
                <span class="text-gray-200 group flex items-center px-2 py-2 text-base font-medium rounded-md">
                  <!-- Heroicon name: outline/document-duplicate -->
                  <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2"></path>
                  </svg>
                  Fork and edit
                </span>
              <% else %>
                <a href="#" class="text-gray-100 hover:text-white hover:bg-gray-600 group flex items-center px-2 py-2 text-base font-medium rounded-md">
                  <!-- Heroicon name: outline/document-duplicate -->
                  <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2"></path>
                  </svg>
                  Fork
                </a>
              <% end %>

              <a href="#" class="text-gray-100 hover:text-white hover:bg-gray-600 group flex items-center px-2 py-2 text-base font-medium rounded-md">
                <!-- Heroicon name: outline/plus-circle -->
                <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                New
              </a>
            </div>
            <div class="mt-6 pt-6">
              <div class="px-2 space-y-1">
                <a href="#" class="group flex items-center px-2 py-2 text-base font-medium rounded-md text-gray-100 hover:text-white hover:bg-gray-600">
                  <!-- Heroicon name: outline/cog -->
                  <svg class="mr-4 h-6 w-6 text-gray-200" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                  Settings
                </a>

                <a href="#" class="group flex items-center px-2 py-2 text-base font-medium rounded-md text-gray-100 hover:text-white hover:bg-gray-600">
                  <!-- Heroicon name: outline/question-mark-circle -->
                  <svg class="mr-4 h-6 w-6 text-gray-200" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  Help
                </a>
              </div>
            </div>
          </nav>
        </div>

        <div class="flex-shrink-0 w-14" aria-hidden="true">
          <!-- Dummy element to force sidebar to shrink to fit close icon -->
        </div>
      </div>

      <!-- Static sidebar for desktop -->
      <div class="hidden lg:flex lg:w-64 lg:flex-col lg:fixed lg:inset-y-0 right-0">
        <!-- Sidebar component, swap this element with another sidebar if you like -->
        <div class="flex flex-col flex-grow bg-gray-700 pt-5 pb-4 overflow-y-auto">
          <div class="flex items-center flex-shrink-0 px-4">
          <span class="text-white text-2xl font-bold leading-7">
            <span class="kbd border border-neutral-focus border-opacity-20 bg-black px-2 rounded-btn">ctrl</span>
            <span class="kbd border border-neutral-focus border-opacity-20 bg-black px-2 rounded-btn">v</span>
            <span class="kbd border border-neutral-focus border-opacity-20 bg-black px-2 rounded-btn">.io</span>
          </span>
          </div>
          <nav class="mt-5 flex-1 flex flex-col divide-y divide-gray-800 overflow-y-auto" aria-label="Sidebar">
            <div class="px-2 space-y-1">
              <%= if @is_editing do %>
                <!-- Current: "bg-gray-800 text-white", Default: "text-gray-100 hover:text-white hover:bg-gray-600" -->
                <a href="#init-save" class="text-gray-100 hover:text-white hover:bg-gray-600 group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md" aria-current="page"
                  phx-click="init-save">
                  <!-- Heroicon name: outline/save -->
                  <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"></path>
                  </svg>
                  Save
                </a>
              <% else %>
                <!-- Current: "bg-gray-800 text-white", Default: "text-gray-100 hover:text-white hover:bg-gray-600" -->
                <span class="text-gray-400 group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md" aria-current="page">
                  <!-- Heroicon name: outline/save -->
                  <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"></path>
                  </svg>
                  Save
                </span>
              <% end %>

              <%= if @is_editing do %>
                <span class="text-gray-400 group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md">
                  <!-- Heroicon name: outline/document-duplicate -->
                  <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2"></path>
                  </svg>
                  Fork and edit
                </span>
              <% else %>
                <a href={Routes.paste_editor_path(@socket, :new, @puid)} class="text-gray-100 hover:text-white hover:bg-gray-600 group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md">
                  <!-- Heroicon name: outline/document-duplicate -->
                  <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2"></path>
                  </svg>
                  Fork and edit
                </a>
              <% end %>

              <a href={Routes.paste_editor_path(@socket, :new)} class="text-gray-100 hover:text-white hover:bg-gray-600 group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md">
                <!-- Heroicon name: outline/plus-circle -->
                <svg class="mr-4 flex-shrink-0 h-6 w-6 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                New
              </a>
            </div>
            <div class="mt-6 pt-6">
              <div class="px-2 space-y-1">

                <%= if @is_editing do %>
                <.form let={f} for={@changeset} phx-change="form-change" phx-submit="save">
                <div class="flex flex-1 flex-col justify-between">
                  <div class="divide-y divide-gray-200 px-2">
                    <div class="space-y-6 pt-6 pb-5">
                      <div>
                        <%= label f, :language, class: "block text-sm font-medium text-gray-300" %>
                        <%= select f, :language, [
                            [key: "C++", value: "cpp"],
                            [key: "CSS", value: "css"],
                            [key: "HTML", value: "html"],
                            [key: "Java", value: "java"],
                            [key: "JavaScript", value: "javascript"],
                            [key: "JSON", value: "json"],
                            [key: "Markdown", value: "markdown"],
                            [key: "PHP", value: "php"],
                            [key: "Python", value: "python"],
                            [key: "Rust", value: "rust"],
                            [key: "----Legacy----", value: "", disabled: true],
                            [key: "apl", value: "apl"],
                            [key: "asciiArmor", value: "asciiArmor"],
                            [key: "asn1", value: "asn1"],
                            [key: "asterisk", value: "asterisk"],
                            [key: "brainfuck", value: "brainfuck"],
                            [key: "c", value: "c"],
                            [key: "csharp", value: "csharp"],
                            [key: "dart", value: "dart"],
                            [key: "clojure", value: "clojure"],
                            [key: "cmake", value: "cmake"],
                            [key: "cobol", value: "cobol"],
                            [key: "coffeeScript", value: "coffeeScript"],
                            [key: "commonLisp", value: "commonLisp"],
                            [key: "crystal", value: "crystal"],
                            [key: "sCSS", value: "sCSS"],
                            [key: "less", value: "less"],
                            [key: "cypher", value: "cypher"],
                            [key: "d", value: "d"],
                            [key: "diff", value: "diff"],
                            [key: "dockerFile", value: "dockerFile"],
                            [key: "dtd", value: "dtd"],
                            [key: "dylan", value: "dylan"],
                            [key: "ebnf", value: "ebnf"],
                            [key: "ecl", value: "ecl"],
                            [key: "eiffel", value: "eiffel"],
                            [key: "elixir", value: "elixir"],
                            [key: "elm", value: "elm"],
                            [key: "erlang", value: "erlang"],
                            [key: "factor", value: "factor"],
                            [key: "fcl", value: "fcl"],
                            [key: "forth", value: "forth"],
                            [key: "fortran", value: "fortran"],
                            [key: "fSharp", value: "fSharp"],
                            [key: "gas", value: "gas"],
                            [key: "gherkin", value: "gherkin"],
                            [key: "go", value: "go"],
                            [key: "groovy", value: "groovy"],
                            [key: "haskell", value: "haskell"],
                            [key: "haxe", value: "haxe"],
                            [key: "http", value: "http"],
                            [key: "idl", value: "idl"],
                            [key: "kotlin", value: "kotlin"],
                            [key: "jinja2", value: "jinja2"],
                            [key: "julia", value: "julia"],
                            [key: "liveScript", value: "liveScript"],
                            [key: "lua", value: "lua"],
                            [key: "mathematica", value: "mathematica"],
                            [key: "mbox", value: "mbox"],
                            [key: "mirc", value: "mirc"],
                            [key: "msSQL", value: "msSQL"],
                            [key: "oCaml", value: "oCaml"],
                            [key: "plSQL", value: "plSQL"],
                            [key: "sml", value: "sml"],
                            [key: "modelica", value: "modelica"],
                            [key: "mscgen", value: "mscgen"],
                            [key: "mumps", value: "mumps"],
                            [key: "nginx", value: "nginx"],
                            [key: "nsis", value: "nsis"],
                            [key: "ntriples", value: "ntriples"],
                            [key: "objectiveC", value: "objectiveC"],
                            [key: "octave", value: "octave"],
                            [key: "oz", value: "oz"],
                            [key: "pascal", value: "pascal"],
                            [key: "perl", value: "perl"],
                            [key: "pig", value: "pig"],
                            [key: "powerShell", value: "powerShell"],
                            [key: "properties", value: "properties"],
                            [key: "protobuf", value: "protobuf"],
                            [key: "puppet", value: "puppet"],
                            [key: "q", value: "q"],
                            [key: "r", value: "r"],
                            [key: "ruby", value: "ruby"],
                            [key: "sas", value: "sas"],
                            [key: "scala", value: "scala"],
                            [key: "scheme", value: "scheme"],
                            [key: "shell", value: "shell"],
                            [key: "sieve", value: "sieve"],
                            [key: "smalltalk", value: "smalltalk"],
                            [key: "solr", value: "solr"],
                            [key: "sparql", value: "sparql"],
                            [key: "spreadsheet", value: "spreadsheet"],
                            [key: "sql", value: "sql"],
                            [key: "stex", value: "stex"],
                            [key: "stylus", value: "stylus"],
                            [key: "swift", value: "swift"],
                            [key: "tcl", value: "tcl"],
                            [key: "textile", value: "textile"],
                            [key: "tiki", value: "tiki"],
                            [key: "toml", value: "toml"],
                            [key: "troff", value: "troff"],
                            [key: "ttcn", value: "ttcn"],
                            [key: "turtle", value: "turtle"],
                            [key: "typescript", value: "typescript"],
                            [key: "vb", value: "vb"],
                            [key: "vbScript", value: "vbScript"],
                            [key: "velocity", value: "velocity"],
                            [key: "verilog", value: "verilog"],
                            [key: "vhdl", value: "vhdl"],
                            [key: "wast", value: "wast"],
                            [key: "webIDL", value: "webIDL"],
                            [key: "xml", value: "xml"],
                            [key: "xQuery", value: "xQuery"],
                            [key: "yacas", value: "yacas"],
                            [key: "yaml", value: "yaml"],
                            [key: "z80", value: "z80"]
                          ],
                          prompt: [key: "Select language", disabled: true],
                          class: "mt-1 block w-full pl-3 pr-10 py-2 text-base text-gray-200 border-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md bg-gray-600"
                        %>
                      </div>
                      <div class="mt-2">
                        <%= label f, :expires_in, "Expires", class: "block text-sm font-medium text-gray-300" %>
                        <%= select f, :expires_in, [
                            "10 minutes": "10_minutes",
                            "1 hour": "1_hour",
                            "1 day": "1_day",
                            "3 days": "3_days",
                            "1 week": "1_week",
                            "1 month": "1_month"
                          ],
                          prompt: [key: "Select expiry", disabled: true],
                          class: "mt-1 block w-full pl-3 pr-10 py-2 text-base text-gray-200 border-gray-900 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md bg-gray-600"
                        %>
                      </div>
                    </div>
                  </div>
                </div>
                </.form>
                <% end %>

                <%# TODO: Add advanced settings, like `tabSize`.
                <a href="#" class="group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md text-gray-100 hover:text-white hover:bg-gray-600">
                  <!-- Heroicon name: outline/cog -->
                  <svg class="mr-4 h-6 w-6 text-gray-200" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                  Advanced Settings
                </a>
                %>

                <%# TODO: Add a help menu.
                <a href="#" class="group flex items-center px-2 py-2 text-sm leading-6 font-medium rounded-md text-gray-100 hover:text-white hover:bg-gray-600">
                  <!-- Heroicon name: outline/question-mark-circle -->
                  <svg class="mr-4 h-6 w-6 text-gray-200" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  Help
                </a>
                %>
              </div>
            </div>
          </nav>
          <%# footer start %>
          <div class="flex flex-shrink-0 justify-end px-4 py-4">
            <div class="w-full">
              <p class="w-full text-center text-sm text-gray-400">
                Copyright &copy Ryan Winchester
              </p>
              <p class="w-full text-center text-sm text-gray-400 mt-1">
                <a href="https://github.com/ryanwinchester/ctrlv" target="_blank">
                  <svg class="w-6 h-6 inline-flex" fill="currentColor" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <title>GitHub</title>
                    <path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/>
                  </svg>
                  <span>Open Source</span>
                </a>
              </p>
            </div>
          </div>
          <%# /end footer %>
        </div>
      </div>
    </div>
    """
  end
end
