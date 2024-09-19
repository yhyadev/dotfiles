import psutil
from typing import Literal
from collections.abc import Iterable, Callable
from fabric import Application
from fabric.core.service import Property
from fabric.widgets.eventbox import EventBox
from fabric.widgets.button import Button
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.overlay import Overlay
from fabric.widgets.datetime import DateTime
from fabric.widgets.centerbox import CenterBox
from fabric.system_tray.widgets import SystemTray
from fabric.widgets.circularprogressbar import CircularProgressBar
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.utils import (
    invoke_repeater,
    get_relative_path,
)
from fabric.utils.helpers import (
    FormattedString,
    invoke_repeater,
    exec_shell_command_async,
)


class TagButton(Button):
    @Property(int, "readable")
    def id(self) -> int:
        return self._id

    @Property(bool, "read-write", default_value=False)
    def active(self) -> bool:
        return self._active

    @active.setter
    def active(self, value: bool):
        self._active = value
        if value is True:
            self.urgent = False
        (self.remove_style_class if not value else self.add_style_class)("active")
        return self.do_bake_label()

    @Property(bool, "read-write", default_value=False)
    def urgent(self) -> bool:
        return self._urgent

    @urgent.setter
    def urgent(self, value: bool):
        self._urgent = value
        (self.remove_style_class if not value else self.add_style_class)("urgent")
        return self.do_bake_label()

    @Property(bool, "read-write", default_value=True)
    def empty(self) -> bool:
        return self._empty

    @empty.setter
    def empty(self, value: bool):
        self._empty = value
        (self.remove_style_class if not value else self.add_style_class)("empty")
        return self.do_bake_label()

    def __init__(
        self,
        id: int,
        label: FormattedString | str | None = None,
        name: str | None = None,
        visible: bool = True,
        all_visible: bool = False,
        style: str | None = None,
        tooltip_text: str | None = None,
        tooltip_markup: str | None = None,
        h_align: Literal["fill", "start", "end", "center", "baseline"] | None = None,
        v_align: Literal["fill", "start", "end", "center", "baseline"] | None = None,
        h_expand: bool = False,
        v_expand: bool = False,
        size: Iterable[int] | int | None = None,
        **kwargs,
    ):
        super().__init__(
            None,
            None,
            None,
            name,
            visible,
            all_visible,
            style,
            tooltip_text,
            tooltip_markup,
            h_align,
            v_align,
            h_expand,
            v_expand,
            size,
            **kwargs,
        )
        self._id: int = id
        self._label: FormattedString | None = (
            FormattedString(label) if isinstance(label, str) else label
        )
        self._active: bool = False
        self._urgent: bool = False
        self._empty: bool = True

        self.active = False
        self.urgent = False
        self.empty = True

    def do_bake_label(self):
        if not self._label:
            return
        return self.set_label(self._label.format(button=self))


class Tags(Box):
    @staticmethod
    def default_buttons_factory(button_id: int):
        return TagButton(id=button_id, label=str(button_id))

    def __init__(
        self,
        **kwargs,
    ):
        super().__init__()
        self._container = Box(**kwargs)
        self.children = self._container

        self._buttons: dict[int, TagButton] = {}

        for i in range(1, 10):
            self.insert_button(Tags.default_buttons_factory(i))

    def insert_button(self, button: TagButton) -> None:
        self._buttons[button.id] = button
        self._container.add(button)
        button.connect("clicked", self.do_handle_button_press)
        return self.reorder_buttons()

    def reorder_buttons(self):
        for _, child in sorted(self._buttons.items(), key=lambda i: i[0]):
            self._container.reorder_child(child, (child.id - 1))
        return

    def remove_button(self, button: TagButton) -> None:
        if self._buttons.pop(button.id, None) is not None:
            self._container.remove(button)
        return button.destroy()

    def lookup_or_bake_button(self, workspace_id: int) -> TagButton | None:
        if not (btn := self._buttons.get(workspace_id)):
            if self._buttons_factory:
                btn = self._buttons_factory(workspace_id)
        return btn

    def do_handle_button_press(self, button: TagButton):
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

        self.tags = Tags(
            name="tags",
            spacing=4,
        )

        self.date_time = DateTime(name="date-time")
        self.cpu_progress_bar = CircularProgressBar(name="cpu-progress-bar", size=24)
        self.ram_progress_bar = CircularProgressBar(name="ram-progress-bar", size=24)

        self.children = CenterBox(
            name="bar-inner",
            start_children=Box(
                name="start-container",
                spacing=4,
                orientation="h",
                children=self.tags,
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
