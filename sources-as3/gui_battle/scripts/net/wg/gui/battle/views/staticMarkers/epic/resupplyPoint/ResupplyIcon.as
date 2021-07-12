package net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleIconHolder;
   
   public class ResupplyIcon extends BattleIconHolder
   {
      
      private static const UNAVAILABLE_STATE:int = 1;
       
      
      public var active:MovieClip = null;
      
      public var unavailable:MovieClip = null;
      
      private var _state:int = -1;
      
      public function ResupplyIcon()
      {
         super();
         this.active.visible = false;
         this.unavailable.visible = false;
         this.setElements(this._state);
      }
      
      override protected function onDispose() : void
      {
         this.active = null;
         this.unavailable = null;
         super.onDispose();
      }
      
      public function setState(param1:int) : void
      {
         this._state = param1;
         this.setElements(this._state);
      }
      
      public function setUnavailableState() : void
      {
         if(this._state != UNAVAILABLE_STATE)
         {
            showItem(this.unavailable);
         }
      }
      
      private function setElements(param1:int) : void
      {
         showItem(param1 == UNAVAILABLE_STATE ? this.unavailable : this.active);
      }
   }
}
