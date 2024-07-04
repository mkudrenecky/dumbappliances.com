defmodule Dumbappliances.AppliancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dumbappliances.Appliances` context.
  """

  @doc """
  Generate a appliance.
  """
  def appliance_fixture(attrs \\ %{}) do
    {:ok, appliance} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        category: "some category",
        contributor: "some contributor",
        name: "some name",
        public: true,
        url: "some url"
      })
      |> Dumbappliances.Appliances.create_appliance()

    appliance
  end
end
