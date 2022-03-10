package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.actionMarkers.ActionMarkerStates;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeadquarterLifeStates extends MovieClip implements IDisposable
   {
      
      private static const LIVE:String = "live";
      
      private static const HIT_PIERCED:String = "hit_pierced";
      
      private static const HIT:String = "hit";
       
      
      public var liveMarkerState:MovieClip;
      
      public var hit_piercedMarkerState:MovieClip;
      
      public var hitMarkerState:MovieClip;
      
      private var _disposed:Boolean = false;
      
      public function HeadquarterLifeStates()
      {
         super();
         if(this.liveMarkerState != null)
         {
            this.liveMarkerState.visible = false;
         }
         if(this.hit_piercedMarkerState != null)
         {
            this.hit_piercedMarkerState.visible = false;
         }
         if(this.hitMarkerState != null)
         {
            this.hitMarkerState.visible = false;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.liveMarkerState = null;
         this.hit_piercedMarkerState = null;
         this.hitMarkerState = null;
      }
      
      public function setActiveState(param1:String, param2:int) : void
      {
         gotoAndStop(param1);
         if(param1 == LIVE)
         {
            this.liveMarkerState.visible = true;
            this.liveMarkerState.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param2]);
         }
         else if(param1 == HIT_PIERCED)
         {
            this.hit_piercedMarkerState.visible = true;
            this.hit_piercedMarkerState.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param2]);
         }
         else if(param1 == HIT)
         {
            this.hitMarkerState.visible = true;
            this.hitMarkerState.gotoAndStop(ActionMarkerStates.STATE_INT_TO_STRING[param2]);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
