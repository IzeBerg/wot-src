package net.wg.gui.lobby.missions.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IMarathonHeaderBlock extends IUIComponentEx
   {
       
      
      function setData(param1:Object) : void;
      
      function setContentTopPadding(param1:int) : void;
      
      function get contentHeight() : int;
   }
}
