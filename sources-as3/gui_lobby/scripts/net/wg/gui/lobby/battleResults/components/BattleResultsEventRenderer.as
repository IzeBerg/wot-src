package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.BattleResultsQuestVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.QuestEvent;
   import net.wg.gui.lobby.interfaces.ISubtaskComponent;
   import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
   import net.wg.gui.lobby.questsWindow.SubtasksList;
   import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class BattleResultsEventRenderer extends UIComponentEx implements ISubtaskComponent
   {
      
      private static const BOTTOM_PADDING:int = 14;
      
      private static const LINKBTN_PADDING:int = 12;
      
      private static const AWARDS_PADDING:int = 5;
      
      private static const LINK_BTN_Y_OFFSET:int = 3;
      
      private static const LABELS_OFFSET:int = 2;
      
      private static const PROGRESS_LIST_BOTTOM_PADDING:int = -10;
      
      private static const PROGRESS_LIST_TOB_PADDING:int = 7;
      
      private static const BATTLE_MATTERS_QUEST_ID:String = "battle_matters";
      
      private static const AWARDS_WIDTH:int = 480;
       
      
      public var taskTF:TextField;
      
      public var linkBtn:SoundButtonEx;
      
      public var statusMC:QuestStatusComponent;
      
      public var counter:QuestsCounter;
      
      public var awards:QuestAwardsBlock;
      
      public var progressList:SubtasksList;
      
      public var alert:MovieClip;
      
      public var lineMC:MovieClip;
      
      private var _data:BattleResultsQuestVO = null;
      
      private var _questInfo:QuestRendererVO = null;
      
      private var _status:String = "";
      
      private var _tasksCount:int = -1;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _linkBtnHasListeners:Boolean = false;
      
      public function BattleResultsEventRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.linkBtn.visible = true;
         this.statusMC.visible = false;
         this.counter.visible = false;
         this.linkBtn.focusable = false;
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.linkBtn.mouseEnabledOnDisabled = true;
         this.linkBtn.mutedSoundTypes = [MouseEvent.MOUSE_DOWN];
         this.taskTF.mouseEnabled = false;
         this.progressList.linkage = Linkages.PROGRESS_ELEMENT;
         this.taskTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
         this.awards.contentAlign = TextFieldAutoSize.RIGHT;
         this.awards.hasFixedHeight = false;
         this.awards.addEventListener(Event.RESIZE,this.onAwardResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         if(this._linkBtnHasListeners)
         {
            this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
            this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         }
         this.linkBtn.dispose();
         this.linkBtn = null;
         this.taskTF = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         if(this._questInfo)
         {
            this._questInfo.dispose();
            this._questInfo = null;
         }
         this.counter.dispose();
         this.counter = null;
         this.statusMC.dispose();
         this.statusMC = null;
         this.lineMC = null;
         this.awards.removeEventListener(Event.RESIZE,this.onAwardResizeHandler);
         this.awards.dispose();
         this.awards = null;
         this.alert = null;
         this.progressList.dispose();
         this.progressList = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data != null)
            {
               visible = true;
               this.checkStatus();
               this.checkCounter();
               this.configureTitle();
               _loc1_ = this.checkLabels() + BOTTOM_PADDING;
               _loc1_ += this.checkAlertMsg(_loc1_);
               _loc1_ += this.checkProgressList(_loc1_);
               _loc1_ += this.checkAwards(_loc1_);
               this.lineMC.y = _loc1_;
               setSize(width,this.lineMC.y);
               this.linkBtn.visible = this._data.isLinkBtnVisible;
               this.linkBtn.enabled = this._data.linkBtnEnabled;
               if(this.linkBtn.visible && !this._linkBtnHasListeners)
               {
                  this._linkBtnHasListeners = true;
                  this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
                  this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
                  this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
               }
               dispatchEvent(new Event(Event.RESIZE));
            }
            else
            {
               visible = false;
            }
         }
      }
      
      public function disableLinkBtns(param1:Vector.<String>) : void
      {
         this.linkBtn.enabled = param1.indexOf(this._questInfo.questID) != -1;
         this.linkBtn.mouseEnabled = true;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._data = new BattleResultsQuestVO(param1);
            this._questInfo = this._data.questInfo;
         }
         invalidateData();
      }
      
      private function configureTitle() : void
      {
         if(this._questInfo.questID.indexOf(BATTLE_MATTERS_QUEST_ID) >= 0)
         {
            this.taskTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
         }
         else
         {
            this.taskTF.textColor = !!StringUtils.isNotEmpty(this._status) ? uint(QuestsStates.CLR_TASK_TF_WITH_STATUS) : uint(QuestsStates.CLR_TASK_TF_NORMAL);
         }
      }
      
      private function hideTooltip() : void
      {
         this._tooltipMgr.hide();
      }
      
      private function checkAwards(param1:int) : int
      {
         var _loc2_:Array = this._data.awards;
         if(_loc2_ && _loc2_.length)
         {
            if(this.awards.parent == null)
            {
               addChild(this.awards);
            }
            this.awards.setActualWidth(AWARDS_WIDTH);
            this.awards.setData(_loc2_);
            this.awards.validateNow();
            this.awards.y = param1 + AWARDS_PADDING;
            return this.awards.height > 0 ? int(this.awards.height + AWARDS_PADDING) : int(0);
         }
         if(this.awards.parent)
         {
            removeChild(this.awards);
         }
         return AWARDS_PADDING;
      }
      
      private function checkProgressList(param1:int) : int
      {
         var _loc2_:Boolean = false;
         _loc2_ = this._data.progressList && this._data.progressList.length > 0;
         this.progressList.visible = _loc2_;
         if(_loc2_)
         {
            this.progressList.y = param1 - PROGRESS_LIST_TOB_PADDING;
            this.progressList.setData(this._data.progressList);
            this.progressList.validateNow();
         }
         return !!_loc2_ ? int(this.progressList.height + BOTTOM_PADDING + PROGRESS_LIST_BOTTOM_PADDING) : int(0);
      }
      
      private function checkAlertMsg(param1:int) : int
      {
         var _loc2_:String = null;
         _loc2_ = this._data.alertMsg;
         this.alert.visible = Boolean(_loc2_);
         this.alert.msgTF.text = _loc2_;
         this.alert.y = param1;
         return !!StringUtils.isNotEmpty(_loc2_) ? int(TextField(this.alert.msgTF).textHeight + BOTTOM_PADDING) : int(0);
      }
      
      private function checkLabels() : int
      {
         var _loc1_:Boolean = false;
         if(this.taskTF.text != this._questInfo.description)
         {
            this.taskTF.text = this._questInfo.description;
            _loc1_ = StringUtils.isNotEmpty(this.taskTF.text);
            this.linkBtn.x = (!!_loc1_ ? this.taskTF.x + this.taskTF.getLineMetrics(this.taskTF.numLines - 1).width + LINKBTN_PADDING : this.taskTF.x) | 0;
            this.linkBtn.y = (!!_loc1_ ? this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height : this.taskTF.y) + LINK_BTN_Y_OFFSET | 0;
         }
         return this.linkBtn.y + this.linkBtn.height + LABELS_OFFSET;
      }
      
      private function checkCounter() : void
      {
         if(this._tasksCount != this._questInfo.tasksCount)
         {
            this._tasksCount = this._questInfo.tasksCount;
            if(this._tasksCount >= 0 && StringUtils.isEmpty(this._status))
            {
               this.counter.visible = true;
               this.counter.textField.text = this._tasksCount.toString();
            }
            else
            {
               this.counter.visible = false;
            }
         }
      }
      
      private function checkStatus() : void
      {
         if(this._status != this._questInfo.status)
         {
            this._status = this._questInfo.status;
            this.statusMC.setStatus(this._status);
            this.statusMC.statusTooltip = this._questInfo.statusTooltip;
         }
      }
      
      private function onLinkBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onLinkBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._data.linkBtnTooltip))
         {
            this._tooltipMgr.show(this._data.linkBtnTooltip);
         }
         else
         {
            this._tooltipMgr.show(!!this.linkBtn.enabled ? this._questInfo.linkTooltip : TOOLTIPS.QUESTS_DISABLELINKBTN_TASK);
         }
      }
      
      private function onLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         this.hideTooltip();
         var _loc2_:QuestEvent = new QuestEvent(QuestEvent.SELECT_QUEST,this._questInfo.questID);
         _loc2_.eventType = this._questInfo.eventType;
         dispatchEvent(_loc2_);
      }
      
      private function onAwardResizeHandler(param1:Event) : void
      {
         dispatchEvent(param1);
      }
   }
}
