defmodule DumbappliancesWeb.ApplianceLive.Index do
  use DumbappliancesWeb, :live_view

  alias Dumbappliances.Appliances
  alias Dumbappliances.Appliances.Appliance

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :appliances, Appliances.list_appliances())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Appliance")
    |> assign(:appliance, Appliances.get_appliance!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Appliance")
    |> assign(:appliance, %Appliance{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Appliances")
    |> assign(:appliance, nil)
  end

  @impl true
  def handle_info({DumbappliancesWeb.ApplianceLive.FormComponent, {:saved, appliance}}, socket) do
    {:noreply, stream_insert(socket, :appliances, appliance)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    appliance = Appliances.get_appliance!(id)
    {:ok, _} = Appliances.delete_appliance(appliance)

    {:noreply, stream_delete(socket, :appliances, appliance)}
  end
end
