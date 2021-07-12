package net.wg.gui.battle.views.staticMarkers.safeZone
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SafeZoneMarker extends Sprite implements IDisposable
   {
       
      
      public var marker:MovieClip = null;
      
      public var bgShadow:MovieClip = null;
      
      public var marker2:MovieClip = null;
      
      public function SafeZoneMarker()
      {
         super();
         this.marker.stop();
         this.marker.visible = false;
      }
      
      public function update(param1:Boolean) : void
      {
         if(param1 == this.marker.visible)
         {
            return;
         }
         this.marker.visible = param1;
         if(param1)
         {
            this.marker.gotoAndPlay(1);
         }
         else
         {
            this.marker.stop();
         }
      }
      
      public function dispose() : void
      {
         this.marker = null;
         this.bgShadow = null;
         this.marker2 = null;
      }
   }
}
