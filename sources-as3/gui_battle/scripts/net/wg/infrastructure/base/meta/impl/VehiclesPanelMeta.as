package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class VehiclesPanelMeta extends BattleDisplayable
   {
       
      
      public var onSelectVehicle:Function;
      
      public var onSwitchVehicle:Function;
      
      public var setVehicleHighlight:Function;
      
      public var onUpdateVehicleOrder:Function;
      
      public function VehiclesPanelMeta()
      {
         super();
      }
      
      public function onSelectVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectVehicle,"onSelectVehicle" + Errors.CANT_NULL);
         this.onSelectVehicle(param1);
      }
      
      public function onSwitchVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onSwitchVehicle,"onSwitchVehicle" + Errors.CANT_NULL);
         this.onSwitchVehicle(param1);
      }
      
      public function setVehicleHighlightS(param1:Number, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setVehicleHighlight,"setVehicleHighlight" + Errors.CANT_NULL);
         this.setVehicleHighlight(param1,param2);
      }
      
      public function onUpdateVehicleOrderS(param1:Array) : void
      {
         App.utils.asserter.assertNotNull(this.onUpdateVehicleOrder,"onUpdateVehicleOrder" + Errors.CANT_NULL);
         this.onUpdateVehicleOrder(param1);
      }
   }
}
