package net.wg.gui.lobby.vehicleInfo
{
   import flash.text.TextField;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoAbilityBlockVO;
   import net.wg.infrastructure.base.SimpleDisposable;
   
   public class AbilityBlock extends SimpleDisposable implements IVehicleInfoBlock
   {
       
      
      public var nameTF:TextField;
      
      public var descriptionTF:TextField;
      
      public function AbilityBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.nameTF = null;
         this.descriptionTF = null;
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:VehicleInfoAbilityBlockVO = VehicleInfoAbilityBlockVO(param1);
         this.nameTF.text = _loc2_.abilityName;
         this.descriptionTF.text = _loc2_.description;
         App.utils.commons.updateTextFieldSize(this.descriptionTF,false,true);
      }
   }
}
