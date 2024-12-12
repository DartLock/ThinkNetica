defmodule Part5phoenixWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use Part5phoenixWeb, :controller` and
  `use Part5phoenixWeb, :live_view`.
  """
  use Part5phoenixWeb, :html

  embed_templates "layouts/*"
end
