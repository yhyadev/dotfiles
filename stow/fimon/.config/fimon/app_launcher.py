import operator
from collections.abc import Iterator
from fabric import Application
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.button import Button
from fabric.widgets.image import Image
from fabric.widgets.entry import Entry
from fabric.widgets.scrolledwindow import ScrolledWindow
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.utils import (
    DesktopApp,
    get_desktop_applications,
    get_relative_path,
    idle_add,
    remove_handler,
)

from gi.repository import Gdk

class AppLauncher(Window):
    def __init__(self, **kwargs):
        super().__init__(
            layer="top",
            anchor="center",
            exclusivity="none",
            keyboard_mode="on-demand",
            visible=False,
            all_visible=False,
            **kwargs,
        )

        self.add_keybinding("Escape", lambda *_: self.application.quit())

        self._arranger_handler: int = 0
        self._all_apps = get_desktop_applications()

        self.viewport = Box(spacing=4, orientation="v")

        self.search = Entry(
            name="search",
            h_expand=True,
            notify_text=lambda entry, *_: self.arrange_viewport(entry.get_text()),
        )

        self.viewed_apps = ScrolledWindow(
            name="viewed_apps",
            min_content_size=(380, 300),
            max_content_size=(380 * 2, 300),
            kinetic_scroll=True,
            child=self.viewport,
        )

        self.add(
            Box(
                style="margin: 4px",
                spacing=8,
                orientation="v",
                children=[
                    Box(
                        spacing=2,
                        orientation="h",
                        children=self.search,
                    ),
                    self.viewed_apps,
                ],
            )
        )

        self.show_all()

    def arrange_viewport(self, query: str = ""):
        remove_handler(self._arranger_handler) if self._arranger_handler else None

        self.viewport.children = []

        filtered_apps_iter = iter(
            [
                app
                for app in self._all_apps
                if query.casefold()
                in (
                    (app.display_name or "")
                    + (" " + app.name + " ")
                    + (app.generic_name or "")
                ).casefold()
            ]
        )

        should_resize = operator.length_hint(filtered_apps_iter) == len(self._all_apps)

        self._arranger_handler = idle_add(
            lambda *args: self.add_next_application(*args)
            or (self.resize_viewport() if should_resize else False),
            filtered_apps_iter,
            pin=True,
        )

        return False

    def add_next_application(self, apps_iter: Iterator[DesktopApp]):
        if not (app := next(apps_iter, None)):
            return False

        self.viewport.add(self.bake_application_slot(app))

        return True

    def resize_viewport(self):
        self.viewed_apps.set_min_content_width(self.viewport.get_allocated_width())

        return False

    def bake_application_slot(self, app: DesktopApp, **kwargs) -> Button:
        return Button(
            name = "viewed_app",
            child=Box(
                orientation="h",
                spacing=10,
                children=[
                    Image(pixbuf=app.get_icon_pixbuf(), h_align="start", size=32),
                    Label(
                        label=app.display_name or "Unknown",
                        v_align="center",
                        h_align="center",
                    ),
                ],
            ),
            on_clicked=lambda *_: (app.launch(), self.application.quit()),
            **kwargs,
        )


if __name__ == "__main__":
    app_launcher = AppLauncher()

    app = Application("app-launcher", app_launcher)
    app.set_stylesheet_from_file(get_relative_path("app_launcher.css"))

    app.run()
