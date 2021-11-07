package net.wg.gui.lobby.vehicleInfo
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoCrewBlockVO;
   
   public class CrewBlock extends Sprite implements IVehicleInfoBlock
   {
       
      
      public var crewTankMan:TextField;
      
      public var crewValue:TextField;
      
      public function CrewBlock()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.crewTankMan = null;
         this.crewValue = null;
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:VehicleInfoCrewBlockVO = VehicleInfoCrewBlockVO(param1);
         this.crewTankMan.text = _loc2_.tankmanType;
         this.crewValue.text = _loc2_.value;
      }
   }
}
