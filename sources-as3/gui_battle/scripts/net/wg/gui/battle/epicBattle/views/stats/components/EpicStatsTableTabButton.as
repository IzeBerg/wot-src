package net.wg.gui.battle.epicBattle.views.stats.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.RadioButton;
   
   public class EpicStatsTableTabButton extends RadioButton
   {
      
      private static const LEFT_LANE_PREFIX:String = "l_";
      
      private static const CENTER_LANE_PREFIX:String = "c_";
      
      private static const RIGHT_LANE_PREFIX:String = "r_";
      
      private static const ALL_LANES_PREFIX:String = "all_";
      
      private static const ON_STATE_POSTFIX:String = "on";
      
      private static const OFF_STATE_POSTFIX:String = "off";
      
      private static const INVALIDATE_LANE:String = "invalidateLane";
       
      
      public var laneIcon:MovieClip = null;
      
      private var _playerLane:int = -1;
      
      private var _statePrefix:String = "";
      
      public function EpicStatsTableTabButton()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_LANE))
         {
            this.laneIcon.gotoAndPlay(this._statePrefix + (!!selected ? ON_STATE_POSTFIX : OFF_STATE_POSTFIX));
         }
      }
      
      override protected function onDispose() : void
      {
         this.laneIcon.stop();
         this.laneIcon = null;
         super.onDispose();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         invalidate(INVALIDATE_LANE);
      }
      
      public function get playerLane() : int
      {
         return this._playerLane;
      }
      
      public function set playerLane(param1:int) : void
      {
         if(param1 == this._playerLane)
         {
            return;
         }
         this._playerLane = param1;
         if(param1 == 1)
         {
            this._statePrefix = LEFT_LANE_PREFIX;
         }
         else if(param1 == 2)
         {
            this._statePrefix = CENTER_LANE_PREFIX;
         }
         else if(param1 == 3)
         {
            this._statePrefix = RIGHT_LANE_PREFIX;
         }
         else
         {
            this._statePrefix = ALL_LANES_PREFIX;
         }
         invalidate(INVALIDATE_LANE);
      }
   }
}
