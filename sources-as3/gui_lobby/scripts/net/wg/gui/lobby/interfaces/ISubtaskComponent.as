package net.wg.gui.lobby.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface ISubtaskComponent extends IUIComponentEx
   {
       
      
      function setData(param1:Object) : void;
      
      function disableLinkBtns(param1:Vector.<String>) : void;
   }
}
