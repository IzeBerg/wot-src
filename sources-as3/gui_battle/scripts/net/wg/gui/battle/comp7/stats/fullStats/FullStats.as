package net.wg.gui.battle.comp7.stats.fullStats
{
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IPoiContainer;
   import net.wg.gui.battle.comp7.stats.components.VoiceChatActivation;
   import net.wg.gui.battle.comp7.stats.components.data.VoiceChatActivationVO;
   import net.wg.gui.battle.comp7.stats.components.events.VoiceChatActivationEvent;
   import net.wg.gui.battle.interfaces.IReservesStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.views.personalReservesTab.PersonalReservesTab;
   import net.wg.infrastructure.base.meta.IComp7FullStatsMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7FullStatsMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class FullStats extends Comp7FullStatsMeta implements IPoiContainer, IReservesStats, IComp7FullStatsMeta
   {
      
      private static const VOICE_CHAT_ACTIVATION_Y_SHIFT:int = -24;
      
      private static const LEFT_SIDE_TEXT_SMALL_Y_SHIFT:int = 31;
      
      private static const TAB_RESERVES_Y_SHIFT:int = 13;
       
      
      public var voiceChatActivation:VoiceChatActivation = null;
      
      public var tabReserves:PersonalReservesTab = null;
      
      private var _tableCtrl:FullStatsTableCtrl = null;
      
      private var _showVoiceChatControl:Boolean = false;
      
      public function FullStats()
      {
         super();
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         this._tableCtrl = new FullStatsTableCtrl(FullStatsTable(statsTable));
         return this._tableCtrl;
      }
      
      override public function updateStageSize(param1:Number, param2:Number) : void
      {
         super.updateStageSize(param1,param2);
         if(this.tabReserves)
         {
            this.tabReserves.width = param1;
            this.tabReserves.height = param2 - this.tabReserves.y;
            this.tabReserves.x = -this.tabReserves.width >> 1;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         header.setLeftSideSmallYShift(LEFT_SIDE_TEXT_SMALL_Y_SHIFT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.voiceChatActivation.addEventListener(VoiceChatActivationEvent.CONTROL_CLICKED,this.onVoiceChatControlClickedHandler);
      }
      
      override protected function setVoiceChatData(param1:VoiceChatActivationVO) : void
      {
         this.voiceChatActivation.setData(param1);
      }
      
      override protected function doUpdateSizeTable(param1:Number, param2:Number) : void
      {
         super.doUpdateSizeTable(param1,param2);
         this.voiceChatActivation.y = statsTable.y + statsTable.height + VOICE_CHAT_ACTIVATION_Y_SHIFT | 0;
         if(this.tabReserves != null)
         {
            this.tabReserves.y = tabs.y + TAB_RESERVES_Y_SHIFT;
         }
      }
      
      override protected function onDispose() : void
      {
         this.voiceChatActivation.removeEventListener(VoiceChatActivationEvent.CONTROL_CLICKED,this.onVoiceChatControlClickedHandler);
         this.voiceChatActivation.dispose();
         this.voiceChatActivation = null;
         if(this.tabReserves != null)
         {
            this.tabReserves = null;
         }
         this._tableCtrl = null;
         super.onDispose();
      }
      
      override protected function setTitle() : void
      {
         if(statsTable.visible)
         {
            super.setTitle();
         }
         else if(this.tabReserves && this.tabReserves.visible)
         {
            title.setTitle(App.utils.locale.makeString(INGAME_GUI.STATISTICS_TAB_PERSONALRESERVES_HEADER_TITLE));
         }
      }
      
      override protected function updateCurrentTab() : void
      {
         var _loc2_:Boolean = false;
         statsTable.visible = tabs.selectedIndex == 0;
         var _loc1_:Boolean = tabs.selectedIndex == 1;
         if(this.tabReserves != null)
         {
            this.tabReserves.visible = _loc1_;
         }
         _loc2_ = statsTable.visible || _loc1_;
         title.visible = _loc2_ && !_loc1_;
         if(_loc2_)
         {
            this.setTitle();
         }
         this.voiceChatActivation.visible = this._showVoiceChatControl && statsTable.visible;
      }
      
      public function as_setVoiceChatControlSelected(param1:Boolean) : void
      {
         this.voiceChatActivation.setIsActive(param1);
      }
      
      public function as_setVoiceChatControlVisible(param1:Boolean) : void
      {
         this.voiceChatActivation.visible = param1 && statsTable.visible;
         this._showVoiceChatControl = param1;
      }
      
      public function getReservesView() : IDAAPIModule
      {
         return this.tabReserves;
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         this._tableCtrl.removePointOfInterest(param1,param2);
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void
      {
         this._tableCtrl.updatePointOfInterest(param1);
      }
      
      private function onVoiceChatControlClickedHandler(param1:VoiceChatActivationEvent) : void
      {
         onVoiceChatControlClickS();
      }
   }
}
