package net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SectorWaypointMarker extends Sprite implements IDisposable
   {
       
      
      public var marker:SectorWaypointIcon = null;
      
      public var arrow:MovieClip = null;
      
      public var txtLabel:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function SectorWaypointMarker()
      {
         super();
         this.marker.visible = true;
         this.arrow.visible = false;
         this.txtLabel.visible = false;
      }
      
      public function clearCountdown() : void
      {
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.marker.dispose();
         this.marker = null;
         this.arrow = null;
         this.txtLabel = null;
      }
      
      public function isAttacker(param1:Boolean) : void
      {
         this.marker.isAttacker(param1);
      }
      
      public function setCountdown(param1:String) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
