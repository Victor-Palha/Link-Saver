defmodule DemoWeb.LinkLive.New do
  use DemoWeb, :live_view

  alias Demo.Links.Link
  alias Demo.Links

  def mount(_params, _session, socket) do
    changeset = Link.changeset(%Link{})

    socket = socket
    |> assign(:form, to_form(changeset))
    {:ok, socket}
  end

  def handle_event("create-url", %{"link" => params}, socket) do
    IO.inspect(params)
    link_params = Map.put(params, "user_id", socket.assigns.current_user.id)

    case Links.create_link(link_params) do
      {:ok, link} -> created_link({:ok, link}, socket)
      {:error, changeset} -> created_link({:error, changeset}, socket)
    end
  end

  defp created_link({:ok, _}, socket) do
    socket = socket
    |> put_flash(:info, "Link created successfully.")
    |> push_navigate(to: "/links")

    {:noreply, socket}
  end

  defp created_link({:error, changeset}, socket) do
    socket = socket
    |> assign(:form, to_form(changeset))

    {:noreply, socket}
  end
end
