package net.wg.gui.bootcamp.messageWindow.interfaces
{
   import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IMessageView extends IUIComponentEx
   {
       
      
      function setMessageData(param1:MessageContentVO) : void;
   }
}
