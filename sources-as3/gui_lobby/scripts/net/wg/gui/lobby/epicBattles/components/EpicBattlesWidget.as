package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
   import net.wg.gui.lobby.hangar.quests.HeaderQuestsEvent;
   import net.wg.gui.lobby.hangar.quests.HeaderQuestsFlags;
   import net.wg.infrastructure.base.meta.IEpicBattlesWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlesWidgetMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesWidget extends EpicBattlesWidgetMeta implements IEpicBattlesWidgetMeta
   {
      
      private static const BG_NORMAL_Y_OFFSET:int = -1;
      
      private static const ALERT_BG_Y_OFFSET:int = 39;
      
      private static const QUEST_FLAG_X_POSS_BIG:int = -80;
      
      private static const QUEST_FLAG_X_POSS_SMALL:int = -60;
       
      
      public var calendarStatus:AlertMessageBlock = null;
      
      public var button:EpicBattlesWidgetButton = null;
      
      public var bg:MovieClip = null;
      
      public var questsFlags:HeaderQuestsFlags = null;
      
      private var _data:EpicBattlesWidgetVO = null;
      
      public function EpicBattlesWidget()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.button.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.button.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.calendarStatus.x = -this.calendarStatus.width >> 1;
         this.mouseEnabled = false;
         this.bg.mouseEnabled = this.bg.mouseChildren = false;
         this.questsFlags.addEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.questsFlags.removeEventListener(HeaderQuestsEvent.HEADER_QUEST_CLICK,this.onBtnHeaderQuestClickHandler);
         this.questsFlags.dispose();
         this.questsFlags = null;
         this.button.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.button.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this.calendarStatus.dispose();
         this.calendarStatus = null;
         this.bg = null;
         this.button.dispose();
         this.button = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function setData(param1:EpicBattlesWidgetVO) : void
      {
         this._data = param1;
         this.button.setData(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data != null)
         {
            this.calendarStatus.visible = this._data.showAlert;
            this.calendarStatus.setLocalData(this._data.calendarStatus);
            this.calendarStatus.btnClickHandler = onChangeServerClickS;
            this.questsFlags.y = this.button.y = this.bg.y = !!this._data.showAlert ? Number(ALERT_BG_Y_OFFSET) : Number(BG_NORMAL_Y_OFFSET);
            this.questsFlags.setData(this._data.questsGroups);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.validateSize();
         }
      }
      
      private function validateSize() : void
      {
         this.button.updateSize();
         if(App.appWidth >= StageSizeBoundaries.WIDTH_1366)
         {
            this.questsFlags.x = QUEST_FLAG_X_POSS_BIG;
         }
         else
         {
            this.questsFlags.x = QUEST_FLAG_X_POSS_SMALL;
         }
      }
      
      private function onBtnHeaderQuestClickHandler(param1:HeaderQuestsEvent) : void
      {
         onQuestBtnClickS(param1.questType,param1.questID);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
         onWidgetClickS();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.NORMAL_BTN,null);
      }
   }
}
