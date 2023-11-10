package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_BUTTONS;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.components.questProgress.data.HeaderProgressDataVO;
   import net.wg.gui.components.questProgress.data.QuestProgressItemVO;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalMissionDetailedViewVO extends BaseMissionDetailedViewVO
   {
      
      private static const AWARDS_FULLY_COMPLETED:String = "awardsFullyCompleted";
      
      private static const BOTTOM_STATUS_TOOLTIP_DATA:String = "bottomStatusTooltipData";
      
      private static const HOLD_AWARD_SHEET_BTN_TOOLTIP_DATA:String = "holdAwardSheetBtnTooltipData";
      
      private static const HEADER_PROGRESS:String = "headerProgress";
      
      private static const BODY_PROGRESS:String = "bodyProgress";
       
      
      public var onPauseBtnIcon:String = "";
      
      public var completeBtnLabel:String = "";
      
      public var retryBtnLabel:String = "";
      
      public var retryBtnTooltip:String = "";
      
      public var awardsFullyCompleted:DataProvider = null;
      
      public var buttonState:uint = 0;
      
      private var _bodyConditions:Vector.<IQuestProgressItemData> = null;
      
      private var _headerConditions:Vector.<IHeaderProgressData> = null;
      
      private var _isHeaderHasProgress:Boolean = true;
      
      private var _bottomStatusTooltipData:ToolTipVO = null;
      
      private var _holdAwardSheetBtnTooltipData:ToolTipVO = null;
      
      public function PersonalMissionDetailedViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:HeaderProgressDataVO = null;
         var _loc7_:int = 0;
         if(param1 == AWARDS_FULLY_COMPLETED)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(param2 is Array,Errors.INVALID_TYPE + "Array");
            this.awardsFullyCompleted = new DataProvider();
            for each(_loc3_ in _loc4_)
            {
               this.awardsFullyCompleted.push(new AwardItemRendererExVO(_loc3_));
            }
            return false;
         }
         if(param1 == BODY_PROGRESS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,BODY_PROGRESS + Errors.INVALID_TYPE + Array);
            this._bodyConditions = new Vector.<IQuestProgressItemData>();
            for each(_loc3_ in _loc4_)
            {
               this._bodyConditions.push(new QuestProgressItemVO(_loc3_));
            }
            return false;
         }
         if(param1 == BOTTOM_STATUS_TOOLTIP_DATA)
         {
            this._bottomStatusTooltipData = new ToolTipVO(param2);
            return false;
         }
         if(param1 == HOLD_AWARD_SHEET_BTN_TOOLTIP_DATA)
         {
            this._holdAwardSheetBtnTooltipData = new ToolTipVO(param2);
            return false;
         }
         if(param1 == HEADER_PROGRESS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,HEADER_PROGRESS + Errors.INVALID_TYPE + Array);
            _loc5_ = _loc4_.length;
            this._headerConditions = new Vector.<IHeaderProgressData>();
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc6_ = new HeaderProgressDataVO(_loc4_[_loc7_]);
               this._headerConditions.push(_loc6_);
               this._isHeaderHasProgress = this._isHeaderHasProgress && _loc6_.progressType != QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_NONE;
               _loc7_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.awardsFullyCompleted != null)
         {
            for each(_loc1_ in this.awardsFullyCompleted)
            {
               _loc1_.dispose();
            }
            this.awardsFullyCompleted.cleanUp();
            this.awardsFullyCompleted = null;
         }
         for each(_loc1_ in this._bodyConditions)
         {
            _loc1_.dispose();
         }
         this._bodyConditions.splice(0,this._bodyConditions.length);
         this._bodyConditions = null;
         for each(_loc1_ in this._headerConditions)
         {
            _loc1_.dispose();
         }
         this._headerConditions.splice(0,this._headerConditions.length);
         this._headerConditions = null;
         this._bottomStatusTooltipData.dispose();
         this._bottomStatusTooltipData = null;
         this._holdAwardSheetBtnTooltipData.dispose();
         this._holdAwardSheetBtnTooltipData = null;
         super.onDispose();
      }
      
      public function get startBtnVisible() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.START_BTN_VISIBLE);
      }
      
      public function get obtainAwardBtnVisible() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.OBTAIN_AWARD_BTN_VISIBLE);
      }
      
      public function get startBtnEnabled() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.START_BTN_ENABLED);
      }
      
      public function get retryBtnVisible() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.RETRY_BTN_VISIBLE);
      }
      
      public function get retryBtnEnabled() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.RETRY_BTN_ENABLED);
      }
      
      public function get discardBtnVisible() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.DISCARD_BTN_VISIBLE);
      }
      
      public function get discardBtnEnabled() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.DISCARD_BTN_ENABLED);
      }
      
      public function get holdAwardSheetBtnVisible() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.HOLD_AWARD_SHEET_BTN_VISIBLE);
      }
      
      public function get holdAwardSheetBtnEnabled() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.HOLD_AWARD_SHEET_BTN_ENABLED);
      }
      
      public function get pauseBtnVisible() : Boolean
      {
         return Boolean(this.buttonState & PERSONAL_MISSIONS_BUTTONS.PAUSE_BTN_VISIBLE);
      }
      
      public function get bodyConditions() : Vector.<IQuestProgressItemData>
      {
         return this._bodyConditions;
      }
      
      public function get bottomStatusTooltipData() : ToolTipVO
      {
         return this._bottomStatusTooltipData;
      }
      
      public function get holdAwardSheetBtnTooltipData() : ToolTipVO
      {
         return this._holdAwardSheetBtnTooltipData;
      }
      
      public function get headerConditions() : Vector.<IHeaderProgressData>
      {
         return this._headerConditions;
      }
      
      public function get isHeaderHasProgress() : Boolean
      {
         return this._isHeaderHasProgress;
      }
   }
}
