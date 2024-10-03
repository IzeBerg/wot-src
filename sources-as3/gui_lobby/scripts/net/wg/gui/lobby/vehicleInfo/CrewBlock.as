package net.wg.gui.lobby.vehicleInfo
{
   import flash.text.TextField;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoCrewBlockVO;
   import net.wg.infrastructure.base.SimpleDisposable;
   
   public class CrewBlock extends SimpleDisposable implements IVehicleInfoBlock
   {
       
      
      public var crewTankMan:TextField;
      
      public var crewValue:TextField;
      
      public function CrewBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.crewTankMan = null;
         this.crewValue = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:VehicleInfoCrewBlockVO = VehicleInfoCrewBlockVO(param1);
         this.crewTankMan.text = _loc2_.tankmanType;
         this.crewValue.text = _loc2_.value;
      }
   }
}
