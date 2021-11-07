package net.wg.gui.lobby.questsWindow.components.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IResizableContent extends IUIComponentEx
   {
       
      
      function setData(param1:Object) : void;
      
      function get isReadyForLayout() : Boolean;
      
      function set isReadyForLayout(param1:Boolean) : void;
      
      function get availableWidth() : Number;
      
      function set availableWidth(param1:Number) : void;
      
      function get contentAlign() : String;
      
      function set contentAlign(param1:String) : void;
      
      function get isNumerated() : Boolean;
      
      function set isNumerated(param1:Boolean) : void;
   }
}
