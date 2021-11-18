package net.wg.gui.lobby.battleRoyale.vehicleInfoView.components
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.geom.Rectangle;
   import net.wg.gui.components.battleRoyale.VehicleWeakZonesBase;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   
   public class VehicleWeakZonesCmp extends VehicleWeakZonesBase implements IViewStackExContent
   {
      
      private static const BOUNDS_RECTANGLE:Rectangle = new Rectangle(0,0,640,520);
       
      
      public function VehicleWeakZonesCmp()
      {
         super();
      }
      
      public function setActive(param1:Boolean) : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle
      {
         if(param1 == this)
         {
            return BOUNDS_RECTANGLE;
         }
         return super.getBounds(param1);
      }
   }
}
