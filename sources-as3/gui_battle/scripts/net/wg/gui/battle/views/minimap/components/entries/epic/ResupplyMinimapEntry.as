package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ResupplyMinimapEntry extends BattleUIComponent
   {
      
      private static const ENABLED_STATE:String = "enabled";
      
      private static const DISABLED_STATE:String = "disabled";
      
      private static const BLOCKED_STATE:String = "blocked";
       
      
      private var _state:String = "enabled";
      
      private var _active:Boolean = false;
      
      public function ResupplyMinimapEntry()
      {
         super();
         gotoAndStop(ENABLED_STATE);
      }
      
      public function setActive(param1:Boolean) : void
      {
         this._active = param1;
         gotoAndStop(!!param1 ? this._state : DISABLED_STATE);
      }
      
      public function setState(param1:int) : void
      {
         this._state = param1 != 1 ? ENABLED_STATE : BLOCKED_STATE;
         if(this._active)
         {
            gotoAndStop(this._state);
         }
      }
   }
}
