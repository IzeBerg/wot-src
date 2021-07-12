package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.battleRoyale.VehicleWeakZonesBase;
   import net.wg.infrastructure.interfaces.IReusable;
   
   public class VehicleWeakZonesCmp extends VehicleWeakZonesBase implements IReusable
   {
       
      
      public function VehicleWeakZonesCmp()
      {
         super();
         engineTf.autoSize = TextFieldAutoSize.LEFT;
         ammunitionTf.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      public function cleanUp() : void
      {
         engineTf.text = ammunitionTf.text = weakZones.source = null;
      }
   }
}
