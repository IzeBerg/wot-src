package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IExchangeHeader extends IDisposable, IUIComponentEx
   {
       
      
      function setData(param1:ExchangeHeaderVO) : void;
      
      function setRates(param1:int, param2:int) : void;
      
      function set useBackDecor(param1:Boolean) : void;
      
      function set useActionOffset(param1:Boolean) : void;
   }
}
