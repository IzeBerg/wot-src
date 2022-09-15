package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.data.constants.LobbyMetrics;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.interfaces.IPaginatorArrowsController;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailsContainerVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionDetailedViewVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionDetailsContainerVO;
   import net.wg.gui.lobby.personalMissions.events.PersonalMissionDetailedViewEvent;
   import net.wg.infrastructure.base.meta.IPersonalMissionDetailsContainerViewMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionDetailsContainerViewMeta;
   
   public class PersonalMissionDetailsContainerView extends PersonalMissionDetailsContainerViewMeta implements IPersonalMissionDetailsContainerViewMeta
   {
      
      private static const BTN_CLOSE_RIGHT_OFFSET:int = -31;
      
      private static const PAGE_BUTTONS_BOTTOM_OFFSET:int = -12;
      
      private static const VIEW_TOP_OFFSET_MIN:int = 67;
      
      private static const ARROW_HORIZONTAL_SHIFT:int = 491;
      
      private static const ARROW_HORIZONTAL_DELTA_SHIFT:int = 173;
      
      private static const ARROW_VERTICAL_SHIFT_WIDE:int = 185;
      
      private static const ARROW_VERTICAL_SHIFT_SHORT:int = 155;
      
      private static const ARROW_HEIGHT_WIDE:int = 245;
      
      private static const ARROW_HEIGHT_SHORT:int = 233;
      
      private static const BG_FADE_IN_TWEEN_ALPHA:Number = 0.6;
      
      private static const VERTICAL_SIZE_BREAK_POINT:int = 880;
      
      private static const VERTICAL_SIZE_ID_WIDE:String = "verticalWide";
      
      private static const VERTICAL_SIZE_ID_SHORT:String = "verticalShort";
      
      private static const NUM_PAGE_OFFSET_X:int = 8;
      
      private static const BG_WIDTH_PADDING:int = 1;
       
      
      public var vignette:Sprite = null;
      
      private var _hasHeaderProgress:Boolean = false;
      
      private var _verticalSizeID:String = "";
      
      public function PersonalMissionDetailsContainerView()
      {
         super();
      }
      
      override protected function createPaginatorController() : IPaginatorArrowsController
      {
         return new PMPaginatorArrowsController(this,pageButtons,arrowLeftBtn,arrowRightBtn,MISSION_DETAILS_PAGE_GROUP);
      }
      
      override protected function getBgFadeInTweenAlpha() : Number
      {
         return BG_FADE_IN_TWEEN_ALPHA;
      }
      
      override protected function getBaseMissionDetailsContainerVOForData(param1:Object) : BaseMissionDetailsContainerVO
      {
         return new PersonalMissionDetailsContainerVO(param1);
      }
      
      override protected function getBaseMissionDetailedViewVOForData(param1:Object) : BaseMissionDetailedViewVO
      {
         return new PersonalMissionDetailedViewVO(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vignette.mouseChildren = this.vignette.mouseEnabled = false;
         view.addEventListener(PersonalMissionDetailedViewEvent.USE_SHEET_CLICKED,this.onViewUseSheetClickedHandler);
         view.addEventListener(PersonalMissionDetailedViewEvent.START_CLICKED,this.onViewStartClickedHandler);
         view.addEventListener(PersonalMissionDetailedViewEvent.RETRY_CLICKED,this.onViewRetryClickedHandler);
         view.addEventListener(PersonalMissionDetailedViewEvent.DISCARD_CLICKED,this.onViewDiscardClickedHandler);
         view.addEventListener(PersonalMissionDetailedViewEvent.OBTAIN_AWARD_CLICKED,this.onViewObtainAwardClickedHandler);
         view.addEventListener(PersonalMissionDetailedViewEvent.ON_PAUSE_CLICKED,this.onViewOnPauseClickedHandler);
         view.y = VIEW_TOP_OFFSET_MIN;
         arrowLeftBtn.height = arrowRightBtn.height = ARROW_HEIGHT_SHORT;
      }
      
      override protected function onDispose() : void
      {
         view.removeEventListener(PersonalMissionDetailedViewEvent.USE_SHEET_CLICKED,this.onViewUseSheetClickedHandler);
         view.removeEventListener(PersonalMissionDetailedViewEvent.START_CLICKED,this.onViewStartClickedHandler);
         view.removeEventListener(PersonalMissionDetailedViewEvent.RETRY_CLICKED,this.onViewRetryClickedHandler);
         view.removeEventListener(PersonalMissionDetailedViewEvent.DISCARD_CLICKED,this.onViewDiscardClickedHandler);
         view.removeEventListener(PersonalMissionDetailedViewEvent.OBTAIN_AWARD_CLICKED,this.onViewObtainAwardClickedHandler);
         view.removeEventListener(PersonalMissionDetailedViewEvent.ON_PAUSE_CLICKED,this.onViewOnPauseClickedHandler);
         this.vignette = null;
         super.onDispose();
      }
      
      override protected function updateLayout() : void
      {
         var _loc1_:Boolean = false;
         waiting.width = _width;
         waiting.height = _height;
         bg.width = _width + BG_WIDTH_PADDING;
         bg.height = _height - TOP_PANEL_HEIGHT;
         view.x = _width >> 1;
         view.y = VIEW_TOP_OFFSET_MIN + Math.max(0,_height - LobbyMetrics.MIN_STAGE_HEIGHT >> 1);
         _loc1_ = false;
         var _loc2_:String = App.appHeight > VERTICAL_SIZE_BREAK_POINT ? VERTICAL_SIZE_ID_WIDE : VERTICAL_SIZE_ID_SHORT;
         if(_loc2_ != this._verticalSizeID)
         {
            _loc1_ = _loc2_ == VERTICAL_SIZE_ID_WIDE;
            this._verticalSizeID = _loc2_;
            pageButtons.visible = _loc1_;
            view.updateVerticalCheckPoint(_loc1_);
         }
         btnClose.x = _width - btnClose.width + BTN_CLOSE_RIGHT_OFFSET | 0;
         this.vignette.width = _width;
         this.vignette.height = _height;
      }
      
      override protected function updateArrowsLayout() : void
      {
         var _loc1_:Boolean = this._verticalSizeID == VERTICAL_SIZE_ID_WIDE;
         var _loc2_:int = !!this._hasHeaderProgress ? int(Values.ZERO) : int(PersonalMissionDetailedView.CONTENT_ADDITIONAL_HEIGHT);
         arrowLeftBtn.y = arrowRightBtn.y = view.y - _loc2_ + (!!_loc1_ ? ARROW_VERTICAL_SHIFT_WIDE : ARROW_VERTICAL_SHIFT_SHORT);
         arrowLeftBtn.height = arrowRightBtn.height = _loc2_ + (!!_loc1_ ? ARROW_HEIGHT_WIDE : ARROW_HEIGHT_SHORT);
         var _loc3_:int = ARROW_HORIZONTAL_SHIFT + Math.min(ARROW_HORIZONTAL_DELTA_SHIFT,_width - LobbyMetrics.MIN_STAGE_WIDTH >> 2);
         arrowLeftBtn.x = view.x - _loc3_;
         arrowRightBtn.x = view.x + _loc3_;
      }
      
      override protected function getPaginatorPos() : Point
      {
         return new Point(view.x,_height - pageButtons.height + PAGE_BUTTONS_BOTTOM_OFFSET | 0);
      }
      
      override protected function setMissionData(param1:BaseMissionDetailedViewVO) : void
      {
         if(param1 != null)
         {
            this._hasHeaderProgress = PersonalMissionDetailedViewVO(param1).isHeaderHasProgress;
            super.setMissionData(param1);
         }
      }
      
      private function onViewObtainAwardClickedHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         obtainAwardS(param1.eventID);
      }
      
      private function onViewStartClickedHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         startMissionS(param1.eventID);
      }
      
      private function onViewRetryClickedHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         retryMissionS(param1.eventID);
      }
      
      private function onViewDiscardClickedHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         discardMissionS(param1.eventID);
      }
      
      private function onViewUseSheetClickedHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         useSheetS(param1.eventID);
      }
      
      private function onViewOnPauseClickedHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         onPauseClickS(param1.eventID);
      }
   }
}
