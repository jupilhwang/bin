#!/usr/bin/env python3

from gi.repository import Wnck, Gtk, Notify
from gi.repository.GLib import Variant
import signal, time

class Kludge:
    def __init__(self):
        self.first = True
        signal.signal(signal.SIGINT, signal.SIG_DFL)
        self.screen = Wnck.Screen.get_default()
        screenWidth = self.screen.get_width()
        scrrenHeight = self.screen.get_height()
        Notify.init("Workspace Switch Notifier")

    def fire_the_kludge(self, data_a, data_b):
#        time.sleep(.1)
        try:
            workspace_num = self.screen.get_active_workspace().get_number() + 1
        except:
            workspace_num = "Some error happened"

        popup = Notify.Notification.new("Workspace: " + str(workspace_num))
        s = Wnck.Screen.get_default()
        popup.set_hint('x', Variant('d', s.get_width()/2))
        popup.set_hint('y', Variant('d', s.get_height()/2))

        # print("show notification x:",s.get_width()/2.,"y:",s.get_height()/2.)
        popup.show()
        time.sleep(0.5)
        popup.close()

    def main(self):
        self.screen.connect("active-workspace-changed", self.fire_the_kludge)
        Gtk.main()

if __name__ == '__main__':
    print("Here comes the kludge")
    Kludge().main()