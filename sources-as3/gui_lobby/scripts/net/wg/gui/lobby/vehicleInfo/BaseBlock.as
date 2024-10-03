package net.wg.gui.lobby.vehicleInfo
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.SimpleDisposable;
   
   public class BaseBlock extends SimpleDisposable implements IVehicleInfoBlock
   {
       
      
      public var baseName:TextField;
      
      public function BaseBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.baseName = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         this.baseName.text = String(param1);
      }
   }
}
