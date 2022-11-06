package net.wg.data.constants
{
   import flash.ui.Keyboard;
   import scaleform.gfx.MouseEventEx;
   
   public class KeysMap
   {
      
      public static var KEY_NONE:Number = 777;
      
      private static var __mapping:Object;
      
      private static var inited:Boolean = false;
       
      
      public function KeysMap()
      {
         super();
      }
      
      private static function init() : void
      {
         inited = true;
         __mapping = new Object();
         __mapping[KEY_NONE] = {
            "command":"NONE",
            "to_show":READABLE_KEY_NAMES.KEY_NONE
         };
         __mapping[MouseEventEx.LEFT_BUTTON] = {
            "command":"MOUSE0",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE0
         };
         __mapping[MouseEventEx.MIDDLE_BUTTON] = {
            "command":"MOUSE2",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE2
         };
         __mapping[MouseEventEx.RIGHT_BUTTON] = {
            "command":"MOUSE1",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE1
         };
         __mapping[4] = {
            "command":"MOUSE4",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE4
         };
         __mapping[5] = {
            "command":"MOUSE5",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE5
         };
         __mapping[6] = {
            "command":"MOUSE6",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE6
         };
         __mapping[7] = {
            "command":"MOUSE7",
            "to_show":READABLE_KEY_NAMES.KEY_MOUSE7
         };
         __mapping[Keyboard.ESCAPE] = {
            "command":"ESCAPE",
            "to_show":READABLE_KEY_NAMES.KEY_ESCAPE
         };
         __mapping[Keyboard.ALTERNATE] = {
            "command":"LALT",
            "to_show":READABLE_KEY_NAMES.KEY_LALT
         };
         __mapping[Keyboard.ENTER] = {
            "command":"ENTER",
            "to_show":READABLE_KEY_NAMES.KEY_ENTER
         };
         __mapping[165] = {
            "command":"RALT",
            "to_show":READABLE_KEY_NAMES.KEY_RALT
         };
         __mapping[Keyboard.TAB] = {
            "command":"TAB",
            "to_show":READABLE_KEY_NAMES.KEY_TAB
         };
         __mapping[Keyboard.CAPS_LOCK] = {
            "command":"CAPSLOCK",
            "to_show":READABLE_KEY_NAMES.KEY_CAPSLOCK
         };
         __mapping[Keyboard.SHIFT] = {
            "command":"LSHIFT",
            "to_show":READABLE_KEY_NAMES.KEY_LSHIFT
         };
         __mapping[161] = {
            "command":"RSHIFT",
            "to_show":READABLE_KEY_NAMES.KEY_RSHIFT
         };
         __mapping[Keyboard.BACKSPACE] = {
            "command":"BACKSPACE",
            "to_show":READABLE_KEY_NAMES.KEY_BACKSPACE
         };
         __mapping[Keyboard.SPACE] = {
            "command":"SPACE",
            "to_show":READABLE_KEY_NAMES.KEY_SPACE
         };
         __mapping[Keyboard.CONTROL] = {
            "command":"LCONTROL",
            "to_show":READABLE_KEY_NAMES.KEY_LCONTROL
         };
         __mapping[163] = {
            "command":"RCONTROL",
            "to_show":READABLE_KEY_NAMES.KEY_RCONTROL
         };
         __mapping[Keyboard.UP] = {
            "command":"UPARROW",
            "to_show":READABLE_KEY_NAMES.KEY_UPARROW
         };
         __mapping[Keyboard.DOWN] = {
            "command":"DOWNARROW",
            "to_show":READABLE_KEY_NAMES.KEY_DOWNARROW
         };
         __mapping[Keyboard.RIGHT] = {
            "command":"RIGHTARROW",
            "to_show":READABLE_KEY_NAMES.KEY_RIGHTARROW
         };
         __mapping[Keyboard.LEFT] = {
            "command":"LEFTARROW",
            "to_show":READABLE_KEY_NAMES.KEY_LEFTARROW
         };
         __mapping[Keyboard.END] = {
            "command":"END",
            "to_show":READABLE_KEY_NAMES.KEY_END
         };
         __mapping[Keyboard.HOME] = {
            "command":"HOME",
            "to_show":READABLE_KEY_NAMES.KEY_HOME
         };
         __mapping[Keyboard.DELETE] = {
            "command":"DELETE",
            "to_show":READABLE_KEY_NAMES.KEY_DELETE
         };
         __mapping[Keyboard.INSERT] = {
            "command":"INSERT",
            "to_show":READABLE_KEY_NAMES.KEY_INSERT
         };
         __mapping[Keyboard.PAGE_UP] = {
            "command":"PGUP",
            "to_show":READABLE_KEY_NAMES.KEY_PGUP
         };
         __mapping[Keyboard.PAGE_DOWN] = {
            "command":"PGDN",
            "to_show":READABLE_KEY_NAMES.KEY_PGDN
         };
         __mapping[Keyboard.NUMPAD_0] = {
            "command":"NUMPAD0",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD0
         };
         __mapping[Keyboard.NUMPAD_1] = {
            "command":"NUMPAD1",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD1
         };
         __mapping[Keyboard.NUMPAD_2] = {
            "command":"NUMPAD2",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD2
         };
         __mapping[Keyboard.NUMPAD_3] = {
            "command":"NUMPAD3",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD3
         };
         __mapping[Keyboard.NUMPAD_4] = {
            "command":"NUMPAD4",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD4
         };
         __mapping[Keyboard.NUMPAD_5] = {
            "command":"NUMPAD5",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD5
         };
         __mapping[Keyboard.NUMPAD_6] = {
            "command":"NUMPAD6",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD6
         };
         __mapping[Keyboard.NUMPAD_7] = {
            "command":"NUMPAD7",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD7
         };
         __mapping[Keyboard.NUMPAD_8] = {
            "command":"NUMPAD8",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD8
         };
         __mapping[Keyboard.NUMPAD_9] = {
            "command":"NUMPAD9",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPAD9
         };
         __mapping[Keyboard.NUMPAD_DIVIDE] = {
            "command":"NUMPADSLASH",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPADSLASH
         };
         __mapping[Keyboard.NUMPAD_SUBTRACT] = {
            "command":"NUMPADMINUS",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPADMINUS
         };
         __mapping[Keyboard.NUMPAD_MULTIPLY] = {
            "command":"NUMPADSTAR",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPADSTAR
         };
         __mapping[Keyboard.NUMPAD_ENTER] = {
            "command":"NUMPADENTER",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPADENTER
         };
         __mapping[Keyboard.NUMPAD_DECIMAL] = {
            "command":"NUMPADPERIOD",
            "to_show":READABLE_KEY_NAMES.KEY_NUMPADCOMMA
         };
         __mapping[Keyboard.NUMPAD_ADD] = {
            "command":"ADD",
            "to_show":READABLE_KEY_NAMES.KEY_ADD
         };
         __mapping[Keyboard.F1] = {
            "command":"F1",
            "to_show":READABLE_KEY_NAMES.KEY_F1
         };
         __mapping[Keyboard.F2] = {
            "command":"F2",
            "to_show":READABLE_KEY_NAMES.KEY_F2
         };
         __mapping[Keyboard.F3] = {
            "command":"F3",
            "to_show":READABLE_KEY_NAMES.KEY_F3
         };
         __mapping[Keyboard.F4] = {
            "command":"F4",
            "to_show":READABLE_KEY_NAMES.KEY_F4
         };
         __mapping[Keyboard.F5] = {
            "command":"F5",
            "to_show":READABLE_KEY_NAMES.KEY_F5
         };
         __mapping[Keyboard.F6] = {
            "command":"F6",
            "to_show":READABLE_KEY_NAMES.KEY_F6
         };
         __mapping[Keyboard.F7] = {
            "command":"F7",
            "to_show":READABLE_KEY_NAMES.KEY_F7
         };
         __mapping[Keyboard.F8] = {
            "command":"F8",
            "to_show":READABLE_KEY_NAMES.KEY_F8
         };
         __mapping[Keyboard.F9] = {
            "command":"F9",
            "to_show":READABLE_KEY_NAMES.KEY_F9
         };
         __mapping[Keyboard.F10] = {
            "command":"F10",
            "to_show":READABLE_KEY_NAMES.KEY_F10
         };
         __mapping[Keyboard.F11] = {
            "command":"F11",
            "to_show":READABLE_KEY_NAMES.KEY_F11
         };
         __mapping[Keyboard.F12] = {
            "command":"F12",
            "to_show":READABLE_KEY_NAMES.KEY_F12
         };
         __mapping[Keyboard.F13] = {
            "command":"F13",
            "to_show":READABLE_KEY_NAMES.KEY_F13
         };
         __mapping[Keyboard.F14] = {
            "command":"F14",
            "to_show":READABLE_KEY_NAMES.KEY_F14
         };
         __mapping[Keyboard.F15] = {
            "command":"F15",
            "to_show":READABLE_KEY_NAMES.KEY_F15
         };
         __mapping[Keyboard.LEFTBRACKET] = {
            "command":"LBRACKET",
            "to_show":READABLE_KEY_NAMES.KEY_LBRACKET
         };
         __mapping[Keyboard.RIGHTBRACKET] = {
            "command":"RBRACKET",
            "to_show":READABLE_KEY_NAMES.KEY_RBRACKET
         };
         __mapping[Keyboard.SEMICOLON] = {
            "command":"SEMICOLON",
            "to_show":READABLE_KEY_NAMES.KEY_SEMICOLON
         };
         __mapping[Keyboard.QUOTE] = {
            "command":"APOSTROPHE",
            "to_show":READABLE_KEY_NAMES.KEY_APOSTROPHE
         };
         __mapping[Keyboard.BACKSLASH] = {
            "command":"BACKSLASH",
            "to_show":READABLE_KEY_NAMES.KEY_BACKSLASH
         };
         __mapping[Keyboard.SLASH] = {
            "command":"SLASH",
            "to_show":READABLE_KEY_NAMES.KEY_SLASH
         };
         __mapping[Keyboard.PERIOD] = {
            "command":"STOP",
            "to_show":READABLE_KEY_NAMES.KEY_PERIOD
         };
         __mapping[Keyboard.COMMA] = {
            "command":"COMMA",
            "to_show":READABLE_KEY_NAMES.KEY_COMMA
         };
         __mapping[Keyboard.MINUS] = {
            "command":"MINUS",
            "to_show":READABLE_KEY_NAMES.KEY_MINUS
         };
         __mapping[Keyboard.EQUAL] = {
            "command":"EQUALS",
            "to_show":READABLE_KEY_NAMES.KEY_EQUALS
         };
      }
      
      public static function get mapping() : Object
      {
         if(!inited)
         {
            init();
         }
         return __mapping;
      }
   }
}
