package net.wg.gui.lobby.clans.profile.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface ITextFieldFrame extends IUIComponentEx
   {
       
      
      function get label() : String;
      
      function set label(param1:String) : void;
      
      function get textAlign() : String;
      
      function set textAlign(param1:String) : void;
      
      function get imageSource() : String;
      
      function set imageSource(param1:String) : void;
   }
}
