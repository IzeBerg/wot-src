package net.wg.gui.battle.views.stats
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
   
   public class SquadTooltip
   {
       
      
      private var _tooltipSquadState:int;
      
      public function SquadTooltip()
      {
         this._tooltipSquadState = DynamicSquadState.NONE;
         super();
      }
      
      private static function getTooltipID(param1:int, param2:Boolean) : String
      {
         switch(param1)
         {
            case DynamicSquadState.INVITE_DISABLED:
               return !!param2 ? INGAME_GUI.DYNAMICSQUAD_ENEMY_DISABLED : INGAME_GUI.DYNAMICSQUAD_ALLY_DISABLED;
            case DynamicSquadState.INVITE_AVAILABLE:
               return !!param2 ? INGAME_GUI.DYNAMICSQUAD_ENEMY_ADD : INGAME_GUI.DYNAMICSQUAD_ALLY_ADD;
            case DynamicSquadState.INVITE_SENT:
               return !!param2 ? INGAME_GUI.DYNAMICSQUAD_ENEMY_WASSENT : INGAME_GUI.DYNAMICSQUAD_ALLY_WASSENT;
            case DynamicSquadState.INVITE_RECEIVED:
               return !!param2 ? INGAME_GUI.DYNAMICSQUAD_ENEMY_RECEIVED : INGAME_GUI.DYNAMICSQUAD_ALLY_RECEIVED;
            default:
               return null;
         }
      }
      
      public function show(param1:int, param2:Boolean, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(this._tooltipSquadState != param1)
         {
            _loc5_ = getTooltipID(param1,param2);
            if(_loc5_)
            {
               _loc6_ = Values.EMPTY_STR;
               if(param3)
               {
                  _loc6_ = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.NEUTRAL_TEXT,App.utils.locale.makeString(!!param4 ? INGAME_GUI.DYNAMICSQUAD_ALLY_ANONYMIZED_CLAN : INGAME_GUI.DYNAMICSQUAD_ALLY_ANONYMIZED_NOCLAN));
               }
               App.toolTipMgr.showComplex(App.toolTipMgr.getNewFormatter().addBody(App.utils.locale.makeString(App.utils.locale.makeString(_loc5_),{"text":_loc6_}),false).make());
               this._tooltipSquadState = param1;
            }
         }
      }
      
      public function hide() : void
      {
         if(this._tooltipSquadState != DynamicSquadState.NONE)
         {
            App.toolTipMgr.hide();
            this._tooltipSquadState = DynamicSquadState.NONE;
         }
      }
   }
}
