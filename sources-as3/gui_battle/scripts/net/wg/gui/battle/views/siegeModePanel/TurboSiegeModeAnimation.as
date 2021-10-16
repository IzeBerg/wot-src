package net.wg.gui.battle.views.siegeModePanel
{
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   
   public class TurboSiegeModeAnimation extends SiegeModeAnimation
   {
      
      private static const ICON_NAME_PREFIX:String = "turbo";
      
      private static const STATE_SWITCHING_NAME:String = "switching";
      
      private static const TURBO_WAVE_ICON_NAME:String = "turbo_wave";
      
      private static const START_SWITCHING_FRAME:uint = 15;
      
      private static const BASE_MODE_TEXT_COLOR:uint = 14408410;
      
      private static const SIEGE_MODE_TEXT_COLOR:uint = 16761699;
      
      private static const TURBO_GLOW_FILTER:GlowFilter = new GlowFilter(15221525,1,4,4);
       
      
      public var turboWaveContainer:MovieClip = null;
      
      private var _turboWave:MovieClip = null;
      
      public function TurboSiegeModeAnimation()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _states.splice(0,_states.length);
         _states = new <String>["base","siege","siege","base"];
         this._turboWave = this.turboWaveContainer.turboWave;
         addFrameScript(START_SWITCHING_FRAME,this.onSwitchingAnimationStart);
      }
      
      private function onSwitchingAnimationStart() : void
      {
         if(this.isSiegeState)
         {
            this.turboWaveContainer.gotoAndPlay(1);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,TURBO_WAVE_ICON_NAME,this._turboWave.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      override protected function onDispose() : void
      {
         addFrameScript(START_SWITCHING_FRAME,null);
         this._turboWave = null;
         this.turboWaveContainer.stop();
         this.turboWaveContainer = null;
         super.onDispose();
      }
      
      override protected function drawSiegeStatusIcon() : void
      {
         var _loc1_:String = ICON_NAME_PREFIX + DELIMITER + _engineState + DELIMITER + _states[_siegeState];
         _atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc1_,statusSiegeIcon.turboStatusSiegeIconGraphics.graphics,Values.EMPTY_STR,true,false,true);
         _switchIndicator.stop();
         if(this.isSiegeState)
         {
            statusSiegeIcon.play();
         }
         else
         {
            statusSiegeIcon.gotoAndStop(1);
         }
      }
      
      override protected function drawSwitchIndicator() : void
      {
         var _loc1_:String = ICON_NAME_PREFIX + DELIMITER + STATE_SWITCHING_NAME + DELIMITER + _engineState + DELIMITER + _states[_siegeState];
         _atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,_loc1_,_switchIndicator.turboSwitchIndicatorGraphics.graphics,Values.EMPTY_STR,true,false,true);
      }
      
      override protected function onSwitchIndicatorAnimation(param1:Number) : void
      {
         if(_engineState != BATTLE_ITEM_STATES.DESTROYED)
         {
            _switchIndicator.play();
         }
         else
         {
            _switchIndicator.stop();
         }
      }
      
      override protected function stopSwitchAnimation() : void
      {
         super.stopSwitchAnimation();
         _switchIndicator.stop();
      }
      
      override protected function getChangeTimeTextColor() : uint
      {
         if(this.isSiegeState)
         {
            return SIEGE_MODE_TEXT_COLOR;
         }
         return BASE_MODE_TEXT_COLOR;
      }
      
      override protected function getChangeTimeTextFilters() : Array
      {
         return !!this.isSiegeState ? [TURBO_GLOW_FILTER] : null;
      }
      
      private function get isSiegeState() : Boolean
      {
         return _siegeState == SIEGE_SWITCHING_ON || _siegeState == SIEGE_STATE_ENABLED;
      }
   }
}
