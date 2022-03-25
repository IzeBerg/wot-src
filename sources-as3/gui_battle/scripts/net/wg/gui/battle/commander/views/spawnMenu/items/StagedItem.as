package net.wg.gui.battle.commander.views.spawnMenu.items
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class StagedItem extends BattleUIComponent
   {
      
      protected static const _INVALID_STAGE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
       
      
      protected var _currentStage:String = null;
      
      public function StagedItem()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._currentStage = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._currentStage && isInvalid(InvalidationType.SIZE))
         {
            gotoAndStop(this._currentStage);
         }
      }
      
      protected function onStageUpdated() : void
      {
      }
      
      public function updateStage(param1:String) : void
      {
         if(param1 == this._currentStage)
         {
            return;
         }
         this._currentStage = param1;
         this.onStageUpdated();
         invalidateSize();
      }
   }
}
