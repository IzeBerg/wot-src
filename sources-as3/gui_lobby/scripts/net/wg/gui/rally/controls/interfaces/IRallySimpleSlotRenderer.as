package net.wg.gui.rally.controls.interfaces
{
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public interface IRallySimpleSlotRenderer extends IUIComponentEx
   {
       
      
      function setStatus(param1:int) : String;
      
      function get index() : int;
      
      function set index(param1:int) : void;
      
      function get slotData() : IRallySlotVO;
      
      function set slotData(param1:IRallySlotVO) : void;
      
      function get helper() : ISlotRendererHelper;
      
      function set helper(param1:ISlotRendererHelper) : void;
      
      function updateComponents() : void;
      
      function cooldown(param1:Boolean) : void;
      
      function formatPlayerName(param1:IUserProps) : void;
   }
}
