import psutil
from fabric import Application
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.overlay import Overlay
from fabric.widgets.datetime import DateTime
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.circularprogressbar import CircularProgressBar
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.utils import (
    invoke_repeater,
    get_relative_path,
)
from fabric.utils.helpers import invoke_repeater


class StatusBar(Window):
    def __init__(
        self,
    ):
        super().__init__(
            name="bar",
            layer="top",
            anchor="left right top",
            margin="10px 10px -2px 10px",
            exclusivity="auto",
            visible=False,
            all_visible=False,
        )

        self.date_time = DateTime(name="date-time")
        self.cpu_progress_bar = CircularProgressBar(name="cpu-progress-bar", size=30)
        self.ram_progress_bar = CircularProgressBar(name="ram-progress-bar", size=30)

        self.children = CenterBox(
            start_children=Box(
                name="start-container",
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
                ],
            ),
            center_children=Box(
                name="center-container",
                spacing=4,
                orientation="h",
                children=[
                    self.date_time,
                ],
            ),
            end_children=Box(
                name="end-container",
                spacing=4,
                orientation="h",
                children=[
                    Overlay(
                        child=self.ram_progress_bar,
                        overlays=Label(
                            name="ram-glyph",
                            label=" ",
                        ),
                    ),
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
