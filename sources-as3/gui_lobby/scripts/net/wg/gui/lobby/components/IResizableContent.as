package net.wg.gui.lobby.components
{
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public interface IResizableContent extends IViewStackContent
   {
       
      
      function setViewSize(param1:Number, param2:Number) : void;
      
      function get centerOffset() : int;
      
      function set centerOffset(param1:int) : void;
      
      function get active() : Boolean;
      
      function set active(param1:Boolean) : void;
   }
}
