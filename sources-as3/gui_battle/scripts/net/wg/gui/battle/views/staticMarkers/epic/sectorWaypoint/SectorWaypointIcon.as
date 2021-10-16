package net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SectorWaypointIcon extends MovieClip implements IDisposable
   {
      
      private static const ATTACK_STATE:String = "attack";
      
      private static const RETREAT_STATE:String = "retreat";
       
      
      public var targetHighlight:MovieClip = null;
      
      public function SectorWaypointIcon()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.targetHighlight = null;
      }
      
      public function isAttacker(param1:Boolean) : void
      {
         if(param1)
         {
            gotoAndStop(ATTACK_STATE);
         }
         else
         {
            gotoAndStop(RETREAT_STATE);
         }
      }
   }
}
