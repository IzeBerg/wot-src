package net.wg.gui.components.advanced.interfaces
{
   import net.wg.gui.interfaces.ISoundButtonEx;
   
   public interface IBackButton extends ISoundButtonEx
   {
       
      
      function set descrLabel(param1:String) : void;
      
      function get descrVisible() : Boolean;
      
      function set descrVisible(param1:Boolean) : void;
   }
}
