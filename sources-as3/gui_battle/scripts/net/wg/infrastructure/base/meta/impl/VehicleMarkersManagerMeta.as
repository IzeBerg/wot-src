package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDAAPIComponent;
   
   public class VehicleMarkersManagerMeta extends BattleDAAPIComponent
   {
       
      
      public var setFocusVehicle:Function;
      
      public function VehicleMarkersManagerMeta()
      {
         super();
      }
      
      public function setFocusVehicleS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setFocusVehicle,"setFocusVehicle" + Errors.CANT_NULL);
         this.setFocusVehicle(param1);
      }
   }
}
