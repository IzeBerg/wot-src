package net.wg.gui.battle.views.epicOverviewMapScreen
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.views.epicOverviewMapScreen.data.EpicOverviewMapScreenVO;
   import net.wg.infrastructure.base.meta.IEpicOverviewMapScreenMeta;
   import net.wg.infrastructure.base.meta.impl.EpicOverviewMapScreenMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   
   public class EpicOverviewMapScreen extends EpicOverviewMapScreenMeta implements IEpicBattleStatisticDataController, IEpicOverviewMapScreenMeta
   {
       
      
      public var generalShortcuts:MovieClip = null;
      
      public var background:MovieClip = null;
      
      private var _dataVO:EpicOverviewMapScreenVO = null;
      
      private var _isAttacker:Boolean = false;
      
      public function EpicOverviewMapScreen()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.generalShortcuts = null;
         this.background = null;
         if(this._dataVO)
         {
            this._dataVO.dispose();
            this._dataVO = null;
         }
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.setDynamicTexts();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.generalShortcuts.visible = this.background.width > this.background.height;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._dataVO)
            {
               this.generalShortcuts.shortcutKey1TX.text = this._dataVO.key1Text;
               this.generalShortcuts.shortcutKey2TX.text = this._dataVO.key2Text;
               this.generalShortcuts.shortcutKey3TX.text = this._dataVO.key3Text;
               this.generalShortcuts.shortcutKey4TX.text = this._dataVO.key4Text;
               this.generalShortcuts.shortcutKey5TX.text = this._dataVO.key5Text;
               this.generalShortcuts.shortcutKey6TX.text = this._dataVO.key6Text;
            }
            this.setDynamicTexts();
         }
      }
      
      override protected function setKeyBindings(param1:EpicOverviewMapScreenVO) : void
      {
         this._dataVO = param1;
         invalidateData();
      }
      
      public function as_updateLaneButtonNames(param1:String, param2:String, param3:String) : void
      {
         this.generalShortcuts.shortcut3TX.text = param1;
         this.generalShortcuts.shortcut4TX.text = param2;
         this.generalShortcuts.shortcut5TX.text = param3;
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
         if(this._isAttacker != param1.isAttacker)
         {
            this._isAttacker = param1.isAttacker;
            this.setDynamicTexts();
         }
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.background.x = 0 - param1 >> 1;
         this.background.y = 0;
         this.background.width = param1;
         this.background.height = param2;
         this.generalShortcuts.x = 0;
         this.generalShortcuts.y = param2 - this.generalShortcuts.height >> 0;
      }
      
      private function setDynamicTexts() : void
      {
         this.generalShortcuts.shortcut2TX.text = !!this._isAttacker ? EPIC_BATTLE.GLOBAL_MSG_ATK_TIME_SHORT : EPIC_BATTLE.GLOBAL_MSG_DEF_TIME_SHORT;
         this.generalShortcuts.shortcut6TX.text = !!this._isAttacker ? EPIC_BATTLE.GLOBAL_MSG_ATK_FOCUS_HQ_SHORT : EPIC_BATTLE.GLOBAL_MSG_DEF_FOCUS_HQ_SHORT;
         this.generalShortcuts.shortcut1TX.text = EPIC_BATTLE.GLOBAL_MSG_SAVE_TANKS_SHORT;
      }
   }
}
