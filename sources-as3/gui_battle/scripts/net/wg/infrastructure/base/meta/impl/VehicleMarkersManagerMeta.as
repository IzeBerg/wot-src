package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDAAPIComponent;
   
   public class VehicleMarkersManagerMeta extends BattleDAAPIComponent
   {
       
      
      public var onMarkerBeingHovered:Function;
      
      public function VehicleMarkersManagerMeta()
      {
         super();
      }
      
      public function onMarkerBeingHoveredS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onMarkerBeingHovered,"onMarkerBeingHovered" + Errors.CANT_NULL);
         this.onMarkerBeingHovered(param1);
      }
   }
}
