package net.wg.gui.battle.ranked
{
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.random.views.BattlePage;
   import net.wg.gui.battle.ranked.infrastructure.RankedStatisticsDataController;
   import net.wg.gui.battle.views.roleDescription.RoleDescription;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.utils.StageSizeBoundaries;
   
   public class RankedBattlePage extends BattlePage
   {
      
      private static const HINT_PANEL_OFFSET_Y:int = 10;
       
      
      protected var roleDescription:RoleDescription = null;
      
      public function RankedBattlePage()
      {
         super();
      }
      
      override public function as_createRoleDescription() : void
      {
         if(this.roleDescription)
         {
            return;
         }
         this.roleDescription = App.utils.classFactory.getComponent(Linkages.ROLE_DESCRIPTION,RoleDescription);
         this.roleDescription.addEventListener(Event.COMPLETE,this.onHideAnimationCompleteHandler);
         addChild(this.roleDescription);
         registerComponent(this.roleDescription,BATTLE_VIEW_ALIASES.ROLE_DESCRIPTION);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = false;
         super.updateStage(param1,param2);
         if(this.roleDescription)
         {
            _loc3_ = param2 <= StageSizeBoundaries.HEIGHT_900;
            this.roleDescription.isHidden = _loc3_;
            if(!_loc3_)
            {
               this.roleDescription.x = param1 >> 1;
               this.roleDescription.y = param2 * 2 / 3 - this.roleDescription.height / 3 | 0;
            }
         }
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new RankedStatisticsDataController(this);
      }
      
      override protected function updateHintPanelPosition() : void
      {
         super.updateHintPanelPosition();
         if(this.roleDescription && !this.roleDescription.isHidden)
         {
            hintPanel.y = this.roleDescription.y + this.roleDescription.bottomBorderY + HINT_PANEL_OFFSET_Y;
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeRoleDescription();
         super.onDispose();
      }
      
      private function removeRoleDescription() : void
      {
         if(this.roleDescription)
         {
            this.roleDescription.removeEventListener(Event.COMPLETE,this.onHideAnimationCompleteHandler);
            removeChild(this.roleDescription);
            this.roleDescription = null;
            unregisterComponent(Linkages.ROLE_DESCRIPTION);
         }
      }
      
      override protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      private function onHideAnimationCompleteHandler(param1:Event) : void
      {
         this.removeRoleDescription();
      }
      
      override protected function get prebattleAmmunitionPanelAvailable() : Boolean
      {
         return true;
      }
   }
}
