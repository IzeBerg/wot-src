package net.wg.gui.lobby.vehicleInfo
{
   import net.wg.infrastructure.interfaces.ISprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IVehicleInfoBlock extends ISprite, IDisposable
   {
       
      
      function setData(param1:Object) : void;
   }
}
