import curses

def wrapper(func, *args, **kwds):
    try:
        stdscr = curses.initscr()
        curses.noecho()
        curses.cbreak()
        stdscr.keypad(1)
        try:
            curses.start_color()
        except:
            pass

        return func(stdscr, *args, **kwds)
    finally:
        if 'stdscr' in locals():
            stdscr.keypad(0)
            curses.echo()
            curses.nocbreak()
            curses.endwin()