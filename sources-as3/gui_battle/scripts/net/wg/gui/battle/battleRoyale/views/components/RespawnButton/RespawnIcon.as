package net.wg.gui.battle.battleRoyale.views.components.RespawnButton
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.IScheduler;
   
   public class RespawnIcon extends BattleUIComponent
   {
      
      private static const ANIM_ENABLED:String = "enabled";
      
      private static const ANIM_DISABLED:String = "disabled";
      
      private static const DELAY:int = 500;
       
      
      private var _isEnabled:Boolean = true;
      
      private var _scheduler:IScheduler;
      
      public function RespawnIcon()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(initialized && isInvalid(InvalidationType.DATA))
         {
            if(this._isEnabled)
            {
               gotoAndStop(ANIM_ENABLED);
            }
            else
            {
               gotoAndPlay(ANIM_DISABLED);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(invalidateData);
         this._scheduler = null;
         super.onDispose();
      }
      
      public function setIsEnabled(param1:Boolean, param2:Boolean = false) : void
      {
         this._scheduler.cancelTask(invalidateData);
         if(param2)
         {
            this._scheduler.scheduleTask(invalidateData,DELAY);
         }
         else
         {
            invalidateData();
         }
         this._isEnabled = param1;
      }
   }
}
