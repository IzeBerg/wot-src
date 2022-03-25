package net.wg.gui.components.hintPanel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class KeyViewer extends Sprite implements IDisposable
   {
      
      public static const DEFAULT_KEY_SIDE_OFFSET:int = 17;
      
      private static const TEXTFIELD_PADDING:int = 5;
      
      private static const LEFT_MOUSE_BUTTON:String = "KEY_MOUSE0";
      
      private static const LEFT_MOUSE_BUTTON_ALTERNATIVE:String = "KEY_LEFTMOUSE";
      
      private static const RIGHT_MOUSE_BUTTON:String = "KEY_MOUSE1";
      
      private static const RIGHT_MOUSE_BUTTON_ALTERNATIVE:String = "KEY_RIGHTMOUSE";
      
      private static const MIDDLE_MOUSE_BUTTON:String = "KEY_MOUSE2";
      
      private static const MIDDLE_MOUSE_BUTTON_ALTERNATIVE:String = "KEY_MIDDLEMOUSE";
      
      private static const ADDITIONAL_MOUSE_BUTTON_UP:String = "KEY_MOUSE3";
      
      private static const ADDITIONAL_MOUSE_BUTTON_DOWN:String = "KEY_MOUSE4";
      
      private static const LEFT_ARROW_BUTTON:String = "KEY_LEFTARROW";
      
      private static const RIGHT_ARROW_BUTTON:String = "KEY_RIGHTARROW";
      
      private static const DOWN_ARROW_BUTTON:String = "KEY_DOWNARROW";
      
      private static const UP_ARROW_BUTTON:String = "KEY_UPARROW";
      
      private static const BUTTONS_WITH_CUSTOM_ICON:Vector.<String> = new <String>[LEFT_MOUSE_BUTTON,LEFT_MOUSE_BUTTON_ALTERNATIVE,RIGHT_MOUSE_BUTTON,RIGHT_MOUSE_BUTTON_ALTERNATIVE,MIDDLE_MOUSE_BUTTON,MIDDLE_MOUSE_BUTTON_ALTERNATIVE,ADDITIONAL_MOUSE_BUTTON_UP,ADDITIONAL_MOUSE_BUTTON_DOWN,LEFT_ARROW_BUTTON,RIGHT_ARROW_BUTTON,DOWN_ARROW_BUTTON,UP_ARROW_BUTTON];
       
      
      public var keyTF:TextField = null;
      
      public var buttonBgMc:Sprite = null;
      
      public var customButtonIcon:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      private var _keySideOffset:int = 17;
      
      public function KeyViewer()
      {
         super();
         this.keyTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.keyTF = null;
         this.buttonBgMc = null;
         this.customButtonIcon = null;
      }
      
      public function setKey(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = false;
         _loc3_ = BUTTONS_WITH_CUSTOM_ICON.indexOf(param1) >= 0;
         this.customButtonIcon.visible = _loc3_;
         this.keyTF.visible = !_loc3_;
         this.buttonBgMc.visible = !_loc3_;
         if(_loc3_)
         {
            this.customButtonIcon.gotoAndStop(param1);
         }
         else
         {
            this.keyTF.x = this._keySideOffset;
            this.keyTF.text = param2;
            this.keyTF.width = this.keyTF.textWidth + TEXTFIELD_PADDING | 0;
            this.buttonBgMc.width = this.keyTF.width + (this._keySideOffset << 1);
         }
      }
      
      public function set keySideOffset(param1:int) : void
      {
         this._keySideOffset = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
