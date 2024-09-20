import psutil
from fabric import Application
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.overlay import Overlay
from fabric.widgets.datetime import DateTime
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.circularprogressbar import CircularProgressBar
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.hyprland.widgets import WorkspaceButton
from fabric.utils import (
    invoke_repeater,
    get_relative_path,
)
from fabric.utils.helpers import (
    invoke_repeater,
    exec_shell_command_async,
)


# Waiting for fabric to make its own river stuff, until then we will use AstalRiver
import gi

gi.require_version("AstalRiver", "0.1")

from gi.repository import AstalRiver

river = AstalRiver.River.new()


class Workspaces(Box):
    @staticmethod
    def default_buttons_factory(button_id: int):
        return WorkspaceButton(id=button_id, label=str(button_id))

    def __init__(
        self,
        **kwargs,
    ):
        super().__init__()
        self._container = Box(**kwargs)
        self.children = self._container

        self._buttons: dict[int, WorkspaceButton] = {}

        for i in range(1, 10):
            self.insert_button(Workspaces.default_buttons_factory(i))

        self.update_buttons()
        river.connect("changed", lambda *_: self.update_buttons())

    def update_buttons(self) -> None:
        focused_tags = int(
            river.get_output(river.get_focused_output()).get_focused_tags()
        )

        # It feels a little magicky but we want it to be in a limited zero extended big endian bit representation
        focused_tag_bits = bin(focused_tags)[2:][::-1].ljust(9, "0")[0:9]

        for i, focused_tag_bit in enumerate(focused_tag_bits):
            if focused_tag_bit == "1":
                self._buttons[i + 1].active = True
            else:
                self._buttons[i + 1].active = False

    def insert_button(self, button: WorkspaceButton) -> None:
        self._buttons[button.id] = button
        self._container.add(button)
        button.connect("clicked", self.do_handle_button_press)
        return self.reorder_buttons()

    def reorder_buttons(self):
        for _, child in sorted(self._buttons.items(), key=lambda i: i[0]):
            self._container.reorder_child(child, (child.id - 1))
        return

    def remove_button(self, button: WorkspaceButton) -> None:
        if self._buttons.pop(button.id, None) is not None:
            self._container.remove(button)
        return button.destroy()

    def lookup_or_bake_button(self, workspace_id: int) -> WorkspaceButton | None:
        if not (btn := self._buttons.get(workspace_id)):
            if self._buttons_factory:
                btn = self._buttons_factory(workspace_id)
        return btn

    def do_handle_button_press(self, button: WorkspaceButton):
        exec_shell_command_async(
            ["riverctl", "set-focused-tags", str(1 << (button.id - 1))], lambda _: None
        )


class StatusBar(Window):
    def __init__(
        self,
    ):
        super().__init__(
            name="bar",
            layer="top",
            anchor="left top right",
            margin="10px 10px -2px 10px",
            exclusivity="auto",
            visible=False,
            all_visible=False,
        )

        self.workspaces = Workspaces(
            name="workspaces",
            spacing=4,
        )

        self.date_time = DateTime(name="date-time")
        self.cpu_progress_bar = CircularProgressBar(name="cpu-progress-bar", size=24)
        self.ram_progress_bar = CircularProgressBar(name="ram-progress-bar", size=24)

        self.children = CenterBox(
            start_children=Box(
                name="start-container",
                spacing=4,
                orientation="h",
                children=self.workspaces,
            ),
            center_children=Box(
                name="center-container",
                spacing=4,
                orientation="h",
                children=[],
            ),
            end_children=Box(
                name="end-container",
                spacing=4,
                orientation="h",
                children=[
                    Overlay(
                        child=self.cpu_progress_bar,
                        overlays=Label(
                            name="cpu-glyph",
                            label=" ",
                        ),
                    ),
                    Overlay(
                        child=self.ram_progress_bar,
                        overlays=Label(
                            name="ram-glyph",
                            label=" ",
                        ),
                    ),
                    self.date_time,
                ],
            ),
        )

        invoke_repeater(1000, self.update_progress_bars)

        self.show_all()

    def update_progress_bars(self):
        self.ram_progress_bar.value = psutil.virtual_memory().percent / 100
        self.cpu_progress_bar.value = psutil.cpu_percent() / 100
        return True


if __name__ == "__main__":
    bar = StatusBar()
    app = Application("bar", bar)
    app.set_stylesheet_from_file(get_relative_path("bar.css"))

    app.run()
