package net.wg.gui.lobby.battleResults.epic
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.QuestEvent;
   import net.wg.gui.lobby.battleResults.epic.vo.EpicQuestProgressInfoItemVO;
   import net.wg.gui.lobby.questsWindow.SubtasksList;
   import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
   import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class EpicBattleResultsEventRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const BOTTOM_PADDING:int = 14;
      
      private static const LINKBTN_PADDING:int = 12;
      
      private static const AWARDS_PADDING:int = 5;
      
      private static const LINK_BTN_Y_OFFSET:int = 3;
      
      private static const LABELS_OFFSET:int = 2;
      
      private static const MUTED_SOUND_TYPES:Array = [MouseEvent.MOUSE_DOWN];
      
      private static const AWARDS_WIDTH:int = 480;
       
      
      public var taskTF:TextField;
      
      public var linkBtn:SoundButtonEx;
      
      public var statusMC:QuestStatusComponent;
      
      public var counter:QuestsCounter;
      
      public var awards:EpicQuestAwardsBlock;
      
      public var progressList:SubtasksList;
      
      private var _data:EpicQuestProgressInfoItemVO = null;
      
      private var _status:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function EpicBattleResultsEventRenderer()
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
         this.linkBtn.mouseEnabledOnDisabled = true;
         this.linkBtn.mutedSoundTypes = MUTED_SOUND_TYPES;
         this.linkBtn.addEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
         this.linkBtn.addEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         this.taskTF.mouseEnabled = false;
         this.progressList.linkage = Linkages.PROGRESS_ELEMENT;
         this.taskTF.textColor = QuestsStates.CLR_TASK_TF_NORMAL;
         this.awards.contentAlign = TextFieldAutoSize.RIGHT;
         this.awards.hasFixedHeight = false;
         this.awards.autoHeight = false;
         this.awards.addEventListener(Event.RESIZE,this.onAwardResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.linkBtn.removeEventListener(ButtonEvent.CLICK,this.onLinkBtnClickHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onLinkBtnRollOutHandler);
         this.linkBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onLinkBtnRollOverHandler);
         this.linkBtn.dispose();
         this.linkBtn = null;
         this.taskTF = null;
         if(this._data)
         {
            this._data = null;
         }
         this.counter.dispose();
         this.counter = null;
         this.statusMC.dispose();
         this.statusMC = null;
         this.awards.removeEventListener(Event.RESIZE,this.onAwardResizeHandler);
         this.awards.dispose();
         this.awards = null;
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
               _loc1_ = this.checkLabels() + BOTTOM_PADDING;
               _loc1_ += this.checkProgressList(_loc1_);
               _loc1_ += this.checkAwards(_loc1_);
               setSize(width,_loc1_);
               dispatchEvent(new Event(Event.RESIZE));
            }
            else
            {
               visible = false;
            }
         }
      }
      
      public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._data = EpicQuestProgressInfoItemVO(param1);
         }
         invalidateData();
      }
      
      private function hideTooltip() : void
      {
         this._tooltipMgr.hide();
      }
      
      private function checkAwards(param1:int) : int
      {
         var _loc2_:Array = null;
         _loc2_ = this._data.rewards;
         if(_loc2_ && _loc2_.length)
         {
            this.awards.visible = true;
            this.awards.setActualWidth(AWARDS_WIDTH);
            this.awards.setData(_loc2_);
            this.awards.validateNow();
            this.awards.y = param1 + AWARDS_PADDING;
            return this.awards.height > 0 ? int(this.awards.height + AWARDS_PADDING) : int(0);
         }
         this.awards.visible = false;
         return AWARDS_PADDING;
      }
      
      private function checkProgressList(param1:int) : int
      {
         var _loc2_:Array = this._data.progressList;
         var _loc3_:Boolean = _loc2_ && _loc2_.length > 0;
         this.progressList.visible = _loc3_;
         if(_loc3_)
         {
            this.progressList.y = param1;
            this.progressList.setData(_loc2_);
            this.progressList.validateNow();
         }
         return !!_loc3_ ? int(this.progressList.height + BOTTOM_PADDING) : int(0);
      }
      
      private function checkLabels() : int
      {
         var _loc1_:Boolean = false;
         if(this.taskTF.text != this._data.name)
         {
            this.taskTF.text = this._data.name;
            _loc1_ = StringUtils.isNotEmpty(this.taskTF.text);
            this.linkBtn.x = (!!_loc1_ ? this.taskTF.x + this.taskTF.getLineMetrics(this.taskTF.numLines - 1).width + LINKBTN_PADDING : this.taskTF.x) | 0;
            this.linkBtn.y = (!!_loc1_ ? this.taskTF.textHeight + this.taskTF.y - this.linkBtn.height : this.taskTF.y) + LINK_BTN_Y_OFFSET | 0;
            this.taskTF.mouseEnabled = false;
         }
         return this.linkBtn.y + this.linkBtn.height + LABELS_OFFSET;
      }
      
      private function checkStatus() : void
      {
         if(this._status != this._data.status)
         {
            this._status = this._data.status;
            this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
            this.statusMC.setStatus(this._status);
            this.statusMC.statusTooltip = this._data.statusTooltip;
            this.taskTF.textColor = !!StringUtils.isNotEmpty(this._status) ? uint(QuestsStates.CLR_TASK_TF_WITH_STATUS) : uint(QuestsStates.CLR_TASK_TF_NORMAL);
         }
      }
      
      private function onLinkBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onLinkBtnRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(!!this.linkBtn.enabled ? TOOLTIPS.QUESTS_LINKBTN_EPIC : TOOLTIPS.QUESTS_DISABLELINKBTN_TASK);
      }
      
      private function onLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         this.hideTooltip();
         var _loc2_:QuestEvent = new QuestEvent(QuestEvent.SELECT_QUEST,this._data.id);
         _loc2_.eventType = this._data.eventType;
         dispatchEvent(_loc2_);
      }
      
      private function onAwardResizeHandler(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      public function get index() : uint
      {
         return 0;
      }
      
      public function set index(param1:uint) : void
      {
      }
      
      public function get owner() : UIComponent
      {
         return undefined;
      }
      
      public function set owner(param1:UIComponent) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function getData() : Object
      {
         return this._data;
      }
   }
}
