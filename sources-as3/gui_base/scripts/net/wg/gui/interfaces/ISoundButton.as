package net.wg.gui.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   
   public interface ISoundButton extends ISoundable, IUIComponentEx
   {
       
      
      function set label(param1:String) : void;
      
      function get label() : String;
      
      function get autoRepeat() : Boolean;
      
      function set autoRepeat(param1:Boolean) : void;
      
      function get autoSize() : String;
      
      function set autoSize(param1:String) : void;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get focusable() : Boolean;
      
      function set focusable(param1:Boolean) : void;
      
      function get selected() : Boolean;
      
      function set selected(param1:Boolean) : void;
      
      function get soundEnabled() : Boolean;
      
      function set soundEnabled(param1:Boolean) : void;
      
      function get soundId() : String;
      
      function set soundId(param1:String) : void;
      
      function get soundType() : String;
      
      function set soundType(param1:String) : void;
      
      function get toggle() : Boolean;
      
      function set toggle(param1:Boolean) : void;
      
      function get mouseEnabledOnDisabled() : Boolean;
      
      function set mouseEnabledOnDisabled(param1:Boolean) : void;
   }
}
