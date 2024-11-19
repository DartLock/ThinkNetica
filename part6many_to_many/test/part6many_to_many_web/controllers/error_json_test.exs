defmodule Part6manyToManyWeb.ErrorJSONTest do
  use Part6manyToManyWeb.ConnCase, async: true

  test "renders 404" do
    assert Part6manyToManyWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Part6manyToManyWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
