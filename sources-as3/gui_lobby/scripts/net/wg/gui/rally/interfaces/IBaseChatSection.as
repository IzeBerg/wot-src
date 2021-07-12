package net.wg.gui.rally.interfaces
{
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IBaseChatSection extends IDisposable, IDisplayObject
   {
       
      
      function getChannelComponent() : ChannelComponent;
      
      function setDescription(param1:String) : void;
      
      function get rallyData() : IRallyVO;
      
      function set rallyData(param1:IRallyVO) : void;
   }
}
