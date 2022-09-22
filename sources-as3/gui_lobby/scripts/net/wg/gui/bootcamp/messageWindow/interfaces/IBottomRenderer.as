package net.wg.gui.bootcamp.messageWindow.interfaces
{
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public interface IBottomRenderer extends IDisposable, IDisplayObject
   {
       
      
      function setData(param1:DataProvider) : void;
   }
}
