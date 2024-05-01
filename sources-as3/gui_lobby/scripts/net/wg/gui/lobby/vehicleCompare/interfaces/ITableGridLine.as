package net.wg.gui.lobby.vehicleCompare.interfaces
{
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITableGridLine extends IDisplayObject, IDisposable
   {
       
      
      function setLeftLinePadding(param1:int) : void;
      
      function setRightLinePadding(param1:int) : void;
   }
}
