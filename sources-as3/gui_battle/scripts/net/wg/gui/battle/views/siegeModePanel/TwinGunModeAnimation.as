package net.wg.gui.battle.views.siegeModePanel
{
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.VehicleModules;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   
   public class TwinGunModeAnimation extends SiegeModeAnimation
   {
      
      private static const STATE_SWITCH_ON_START:String = "startSwitchOn";
      
      private static const STATE_SWITCHING_ON:String = "switchingOn";
      
      private static const STATE_SWITCH_ON_END:String = "endSwitchOn";
      
      private static const STATE_SWITCHED_ON:String = "switchedOn";
      
      private static const STATE_SWITCH_OFF_START:String = "startSwitchOff";
      
      private static const STATE_SWITCHING_OFF:String = "switchingOff";
      
      private static const STATE_SWITCH_OFF_END:String = "endSwitchOff";
      
      private static const STATE_SWITCHED_OFF:String = "switchedOff";
      
      private static const BASE_TEXT_COLOR:uint = 14408410;
      
      private static const SIEGE_TEXT_COLOR:uint = 16761699;
      
      private static const DESTROYED_TEXT_COLOR:uint = 16711680;
      
      private static const DESTROYED_COLOR_TRANSFORM:ColorTransform = new ColorTransform(1,0,0,1,255,0,0,0);
      
      private static const SIEGE_GLOW_FILTER:GlowFilter = new GlowFilter(15221525,1,4,4);
       
      
      public function TwinGunModeAnimation()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.gotoAndStop(STATE_SWITCHED_OFF);
         statusSiegeIcon.gotoAndStop(STATE_SWITCHED_OFF);
         switchIndicatorContainer.gotoAndStop(STATE_SWITCHED_OFF);
      }
      
      override protected function setAutoSiegeState() : void
      {
         if(siegeState == SIEGE_STATE_ENABLED)
         {
            this.gotoAndStop(STATE_SWITCHED_ON);
            statusSiegeIcon.gotoAndStop(STATE_SWITCHED_ON);
         }
         else
         {
            this.gotoAndStop(STATE_SWITCHED_OFF);
            statusSiegeIcon.gotoAndStop(STATE_SWITCHED_OFF);
         }
         switchIndicatorContainer.gotoAndStop(STATE_SWITCHED_OFF);
         this.drawSiegeStatusIcon();
      }
      
      override protected function updateSiegeState(param1:Boolean) : void
      {
         switch(siegeState)
         {
            case SIEGE_STATE_DISABLED:
               if(param1)
               {
                  this.gotoAndPlay(STATE_SWITCH_OFF_END);
                  statusSiegeIcon.gotoAndPlay(STATE_SWITCH_OFF_END);
                  switchIndicatorContainer.gotoAndPlay(STATE_SWITCH_OFF_END);
               }
               else
               {
                  this.gotoAndStop(STATE_SWITCHED_OFF);
                  statusSiegeIcon.gotoAndStop(STATE_SWITCHED_OFF);
                  switchIndicatorContainer.gotoAndStop(STATE_SWITCHED_OFF);
               }
               break;
            case SIEGE_SWITCHING_ON:
               if(param1)
               {
                  this.gotoAndPlay(STATE_SWITCH_ON_START);
                  statusSiegeIcon.gotoAndPlay(STATE_SWITCH_ON_START);
                  switchIndicatorContainer.gotoAndPlay(STATE_SWITCH_ON_START);
               }
               else
               {
                  this.gotoAndStop(STATE_SWITCHING_ON);
                  statusSiegeIcon.gotoAndStop(STATE_SWITCHING_ON);
                  switchIndicatorContainer.gotoAndStop(STATE_SWITCHING_ON);
               }
               break;
            case SIEGE_STATE_ENABLED:
               if(param1)
               {
                  this.gotoAndPlay(STATE_SWITCH_ON_END);
                  statusSiegeIcon.gotoAndPlay(STATE_SWITCH_ON_END);
                  switchIndicatorContainer.gotoAndPlay(STATE_SWITCH_ON_END);
               }
               else
               {
                  this.gotoAndStop(STATE_SWITCHED_ON);
                  statusSiegeIcon.gotoAndStop(STATE_SWITCHED_ON);
                  switchIndicatorContainer.gotoAndStop(STATE_SWITCHED_ON);
               }
               break;
            case SIEGE_SWITCHING_OFF:
               if(param1)
               {
                  this.gotoAndPlay(STATE_SWITCH_OFF_START);
                  statusSiegeIcon.gotoAndPlay(STATE_SWITCH_OFF_START);
                  switchIndicatorContainer.gotoAndPlay(STATE_SWITCH_OFF_START);
               }
               else
               {
                  this.gotoAndStop(STATE_SWITCHING_OFF);
                  statusSiegeIcon.gotoAndStop(STATE_SWITCHING_OFF);
                  switchIndicatorContainer.gotoAndStop(STATE_SWITCHING_OFF);
               }
         }
         this.drawSiegeStatusIcon();
      }
      
      override protected function getChangeTimeTextColor() : uint
      {
         if(moduleState == BATTLE_ITEM_STATES.DESTROYED)
         {
            return DESTROYED_TEXT_COLOR;
         }
         if(this.isSiegeState)
         {
            return SIEGE_TEXT_COLOR;
         }
         return BASE_TEXT_COLOR;
      }
      
      override protected function getChangeTimeTextFilters() : Array
      {
         return this.isSiegeState && moduleState != BATTLE_ITEM_STATES.DESTROYED ? [SIEGE_GLOW_FILTER] : null;
      }
      
      override protected function drawSiegeStatusIcon() : void
      {
         if(moduleState == BATTLE_ITEM_STATES.DESTROYED)
         {
            statusSiegeIcon.transform.colorTransform = DESTROYED_COLOR_TRANSFORM;
         }
         else
         {
            statusSiegeIcon.transform.colorTransform = null;
         }
      }
      
      override protected function drawSwitchIndicator() : void
      {
         if(moduleState == BATTLE_ITEM_STATES.DESTROYED)
         {
            switchIndicatorContainer.transform.colorTransform = DESTROYED_COLOR_TRANSFORM;
         }
         else
         {
            switchIndicatorContainer.transform.colorTransform = null;
         }
      }
      
      override protected function onSwitchIndicatorAnimation(param1:Number) : void
      {
         if(moduleState != BATTLE_ITEM_STATES.DESTROYED)
         {
            switchIndicator.play();
         }
         else
         {
            switchIndicator.stop();
         }
      }
      
      override protected function get primaryModuleName() : String
      {
         return VehicleModules.GUN;
      }
      
      override protected function get showTimeLeft() : Boolean
      {
         return true;
      }
      
      private function get isSiegeState() : Boolean
      {
         return siegeState == SIEGE_SWITCHING_ON || siegeState == SIEGE_STATE_ENABLED;
      }
   }
}
