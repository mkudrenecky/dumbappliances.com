defmodule DumbappliancesWeb.ApplianceLiveTest do
  use DumbappliancesWeb.ConnCase

  import Phoenix.LiveViewTest
  import Dumbappliances.AppliancesFixtures

  @create_attrs %{name: "some name", public: true, category: "some category", url: "some url", brand: "some brand", contributor: "some contributor"}
  @update_attrs %{name: "some updated name", public: false, category: "some updated category", url: "some updated url", brand: "some updated brand", contributor: "some updated contributor"}
  @invalid_attrs %{name: nil, public: false, category: nil, url: nil, brand: nil, contributor: nil}

  defp create_appliance(_) do
    appliance = appliance_fixture()
    %{appliance: appliance}
  end

  describe "Index" do
    setup [:create_appliance]

    test "lists all appliances", %{conn: conn, appliance: appliance} do
      {:ok, _index_live, html} = live(conn, ~p"/appliances")

      assert html =~ "Listing Appliances"
      assert html =~ appliance.name
    end

    test "saves new appliance", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/appliances")

      assert index_live |> element("a", "New Appliance") |> render_click() =~
               "New Appliance"

      assert_patch(index_live, ~p"/appliances/new")

      assert index_live
             |> form("#appliance-form", appliance: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#appliance-form", appliance: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/appliances")

      html = render(index_live)
      assert html =~ "Appliance created successfully"
      assert html =~ "some name"
    end

    test "updates appliance in listing", %{conn: conn, appliance: appliance} do
      {:ok, index_live, _html} = live(conn, ~p"/appliances")

      assert index_live |> element("#appliances-#{appliance.id} a", "Edit") |> render_click() =~
               "Edit Appliance"

      assert_patch(index_live, ~p"/appliances/#{appliance}/edit")

      assert index_live
             |> form("#appliance-form", appliance: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#appliance-form", appliance: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/appliances")

      html = render(index_live)
      assert html =~ "Appliance updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes appliance in listing", %{conn: conn, appliance: appliance} do
      {:ok, index_live, _html} = live(conn, ~p"/appliances")

      assert index_live |> element("#appliances-#{appliance.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#appliances-#{appliance.id}")
    end
  end

  describe "Show" do
    setup [:create_appliance]

    test "displays appliance", %{conn: conn, appliance: appliance} do
      {:ok, _show_live, html} = live(conn, ~p"/appliances/#{appliance}")

      assert html =~ "Show Appliance"
      assert html =~ appliance.name
    end

    test "updates appliance within modal", %{conn: conn, appliance: appliance} do
      {:ok, show_live, _html} = live(conn, ~p"/appliances/#{appliance}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Appliance"

      assert_patch(show_live, ~p"/appliances/#{appliance}/show/edit")

      assert show_live
             |> form("#appliance-form", appliance: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#appliance-form", appliance: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/appliances/#{appliance}")

      html = render(show_live)
      assert html =~ "Appliance updated successfully"
      assert html =~ "some updated name"
    end
  end
end
