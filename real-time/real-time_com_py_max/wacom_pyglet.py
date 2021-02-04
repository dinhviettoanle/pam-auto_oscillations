import pyglet
import pythonosc 
from pythonosc import osc_message_builder
from pythonosc import udp_client

window = pyglet.window.Window(640, 480)
tablets = pyglet.input.get_tablets()
canvases = []
client = udp_client.UDPClient('127.0.0.1', 8000)

if tablets:
    print('Tablets:')
    for i, tablet in enumerate(tablets):
        print('  (%d) %s' % (i + 1, tablet.name))
    print('Press number key to open corresponding tablet device.')
else:
    print('No tablets found.')

@window.event
def on_text(text): 
    # Quand on a tapé le numéro de la tablette
    try:
        index = int(text) - 1
    except ValueError:
        return

    if not (0 <= index < len(tablets)):
        return

    name = tablets[i].name

    try:
        wintablet = tablets[i].open(window)
    except pyglet.input.DeviceException:
        print('Failed to open tablet %d on window' % index)

    print('Opened %s' % name)

    @wintablet.event
    def on_enter(cursor):
        print('%s: on_enter(%r)' % (name, cursor))

    @wintablet.event
    def on_leave(cursor):
        print('%s: on_leave(%r)' % (name, cursor))

    @wintablet.event
    def on_motion(cursor, x, y, pressure, a, b):
        print('%s: on_motion(%r, x=%r, y=%r, pressure=%r, %s, %s)' % (name, cursor, x, y, pressure, a, b))
        msg = osc_message_builder.OscMessageBuilder(address = '/up_wintablet')
        msg.add_arg('%r, %r, %r' % (x, y, pressure))
        msg = msg.build()
        client.send(msg)

@window.event
def on_mouse_press(x, y, button, modifiers):
    print('on_mouse_press(%r, %r, %r, %r)' % (x, y, button, modifiers))
    msg = osc_message_builder.OscMessageBuilder(address = '/mouse_press')
    msg = msg.build()
    client.send(msg)

@window.event
def on_mouse_release(x, y, button, modifiers):
    print('on_mouse_release(%r, %r, %r, %r)' % (x, y, button, modifiers))
    msg = osc_message_builder.OscMessageBuilder(address = '/mouse_release')
    msg = msg.build()
    client.send(msg)

pyglet.app.run()

