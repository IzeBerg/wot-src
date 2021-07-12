package net.wg.gui.battle.views.staticMarkers.flag
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleIconHolder;
   import net.wg.gui.battle.views.staticMarkers.flag.constant.FlagMarkerState;
   
   public class FlagIcon extends BattleIconHolder
   {
       
      
      public var cooldown:MovieClip = null;
      
      public var ally:MovieClip = null;
      
      public var enemy:MovieClip = null;
      
      public var neutral:MovieClip = null;
      
      public function FlagIcon()
      {
         super();
         this.cooldown.visible = false;
         this.ally.visible = false;
         this.enemy.visible = false;
         this.neutral.visible = false;
      }
      
      public function showMarker(param1:String) : void
      {
         if(param1 == FlagMarkerState.STATE_ALLY)
         {
            showItem(this.ally);
         }
         else if(param1 == FlagMarkerState.STATE_COOLDOWN)
         {
            showItem(this.cooldown);
         }
         else if(param1 == FlagMarkerState.STATE_ENEMY)
         {
            showItem(this.enemy);
         }
         else if(param1 == FlagMarkerState.STATE_NEUTRAL)
         {
            showItem(this.neutral);
         }
         else
         {
            hide();
         }
      }
      
      override protected function onDispose() : void
      {
         this.cooldown = null;
         this.ally = null;
         this.enemy = null;
         this.neutral = null;
         super.onDispose();
      }
   }
}
