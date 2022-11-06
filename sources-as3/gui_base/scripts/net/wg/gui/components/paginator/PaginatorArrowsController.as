package net.wg.gui.components.paginator
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.containers.ButtonGroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.interfaces.IPaginatorArrowsController;
   import net.wg.gui.events.PaginationGroupEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.utils.ILocale;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class PaginatorArrowsController extends EventDispatcher implements IPaginatorArrowsController
   {
      
      private static const TO_PREV_PAGE_BTN_NAME:String = "prevPageBtn";
      
      private static const TO_NEXT_PAGE_BTN_NAME:String = "nextPageBtn";
      
      private static const NAV_BUTTON_WIDTH:uint = 168;
      
      private static const NAV_BUTTON_MIN_WIDTH:uint = 74;
      
      private static const PAGE_BUTTONS_Y_SHIFT:int = -15;
      
      private static const PAGE_BUTTON_RIGHT_X_SHIFT:int = -1;
      
      private static const PAGE_BUTTON_LEFT_X_SHIFT:int = 15;
      
      private static const PAGINATOR_X_SHIFT:int = 9;
      
      private static const AFTER_ARROW_CLICK_CALL_CALLBACK_DELAY:int = 300;
      
      private static const MIN_WIDTH:uint = 1200;
       
      
      private var _allowPageChange:Boolean = true;
      
      private var _hideDisabledArrows:Boolean = false;
      
      private var _holder:DisplayObjectContainer;
      
      private var _prevPageBtn:PaginationPageButton = null;
      
      private var _nextPageBtn:PaginationPageButton = null;
      
      private var _locale:ILocale = null;
      
      private var _arrowLeftBtn:ISoundButtonEx;
      
      private var _arrowRightBtn:ISoundButtonEx;
      
      private var _pageButtons:PaginationGroup;
      
      private var _buttonGroup:ButtonGroupEx;
      
      private var _currentMissionIndex:int = -1;
      
      private var _currentPageIndex:int = 0;
      
      private var _maxPagesLen:int = 0;
      
      private var _maxElementsPerPage:int = 0;
      
      private var _pagesData:DataProvider = null;
      
      private var _hasPagesBtns:Boolean = false;
      
      private var _isCenterPages:Boolean = false;
      
      private var _paginatorPos:Point = null;
      
      private var _disposed:Boolean = false;
      
      public function PaginatorArrowsController(param1:DisplayObjectContainer, param2:PaginationGroup, param3:ISoundButtonEx, param4:ISoundButtonEx, param5:String, param6:int = 0, param7:Boolean = false, param8:int = 0, param9:Boolean = false)
      {
         super();
         this._locale = App.utils.locale;
         this._holder = param1;
         this._pageButtons = param2;
         this._arrowLeftBtn = param3;
         this._arrowRightBtn = param4;
         this._hideDisabledArrows = param7;
         this._arrowLeftBtn.visible = this._arrowRightBtn.visible = false;
         this._arrowRightBtn.mouseEnabledOnDisabled = this._arrowLeftBtn.mouseEnabledOnDisabled = true;
         this._maxElementsPerPage = param6;
         this._isCenterPages = param9;
         var _loc10_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc10_.gap = param8;
         this._pageButtons.layout = _loc10_;
         this._pageButtons.itemRendererLinkage = Linkages.PAGINATION_DETAILS_NUM_BUTTON;
         this._pageButtons.addEventListener(PaginationGroupEvent.GROUP_CHANGED,this.onPageButtonsGroupChangedHandler);
         this._buttonGroup = ButtonGroupEx.getGroup(param5,DisplayObjectContainer(this._pageButtons));
         this._pageButtons.maxElementsPerPage = this._maxElementsPerPage;
         this._arrowLeftBtn.addEventListener(ButtonEvent.CLICK,this.onArrowLeftBtnClickHandler);
         this._arrowRightBtn.addEventListener(ButtonEvent.CLICK,this.onArrowRightBtnClickHandler);
         this._arrowLeftBtn.addEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
         this._arrowRightBtn.addEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
         this._arrowLeftBtn.addEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
         this._arrowRightBtn.addEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
         this._buttonGroup.addEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function getPageIndex() : int
      {
         return this._currentMissionIndex;
      }
      
      public function getSelectedButton() : Button
      {
         return this._buttonGroup.selectedButton;
      }
      
      public function setPageIndex(param1:int) : void
      {
         if(this._currentMissionIndex == param1 || !this._allowPageChange)
         {
            return;
         }
         var _loc2_:int = param1 / this._maxElementsPerPage;
         if(_loc2_ != this._currentPageIndex)
         {
            this.switchPage(_loc2_,param1);
         }
         else
         {
            this._currentMissionIndex = param1;
            this.onPageUpdate();
         }
      }
      
      public function setPages(param1:DataProvider) : void
      {
         this._pagesData = param1;
         this._pageButtons.dataProvider = param1;
         this._maxPagesLen = this._pageButtons.getPagesCount();
         this._pageButtons.validateNow();
         this._arrowLeftBtn.visible = this._arrowRightBtn.visible = this._pagesData.length > 1;
      }
      
      public function setPositions(param1:Point) : void
      {
         this._paginatorPos = param1;
         this._pageButtons.x = this._paginatorPos.x - (this._pageButtons.width >> 1) + PAGINATOR_X_SHIFT;
         this._pageButtons.y = this._paginatorPos.y;
         this.layoutPageBtns();
      }
      
      public function updateSize(param1:int, param2:int) : void
      {
         this.updatePageBtns();
      }
      
      protected function updatePageBtns() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:Boolean = App.appWidth <= MIN_WIDTH;
         if(this._hasPagesBtns)
         {
            this._nextPageBtn.isMinimize = _loc1_;
            this._nextPageBtn.width = !!_loc1_ ? Number(NAV_BUTTON_MIN_WIDTH) : Number(NAV_BUTTON_WIDTH);
            if(!_loc1_)
            {
               _loc2_ = this._pageButtons.getProviderRealLength() - (this._currentPageIndex + 1) * this._maxElementsPerPage;
               _loc2_ = _loc2_ > this._maxElementsPerPage ? uint(this._maxElementsPerPage) : uint(_loc2_);
               this._nextPageBtn.label = this._locale.makeString(QUESTS.MISSIONDETAILS_NEXTPAGEBTN_LABEL) + " " + _loc2_;
            }
            this._prevPageBtn.isMinimize = _loc1_;
            this._prevPageBtn.width = !!_loc1_ ? Number(NAV_BUTTON_MIN_WIDTH) : Number(NAV_BUTTON_WIDTH);
            if(!_loc1_)
            {
               this._prevPageBtn.label = this._locale.makeString(QUESTS.MISSIONDETAILS_PREVPAGEBTN_LABEL) + " " + this._maxElementsPerPage;
            }
         }
      }
      
      protected function gatButtonByIndex(param1:int) : Button
      {
         var _loc2_:int = this._pageButtons.getRendererIndex(param1);
         return this._buttonGroup.getButtonAt(_loc2_);
      }
      
      protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.afterArrowClickCallback);
         this.removeListeners();
         this._locale = null;
         this.clearPagesBtns();
         this._holder = null;
         this._pagesData = null;
         this._arrowLeftBtn = null;
         this._arrowRightBtn = null;
         this._pageButtons = null;
         this._buttonGroup = null;
         this._paginatorPos = null;
      }
      
      protected function showArrowTooltip(param1:int) : void
      {
      }
      
      protected function arrowRightBtnClickHandler() : void
      {
         this.setPageIndex(this._currentMissionIndex + 1);
      }
      
      protected function arrowLeftBtnClickHandler() : void
      {
         this.setPageIndex(this._currentMissionIndex - 1);
      }
      
      protected function getPageDataByIdx(param1:int) : Object
      {
         return this._pagesData[param1];
      }
      
      protected function getFirstMissionIndex() : int
      {
         return 0;
      }
      
      protected function getLastMissionIndex() : int
      {
         return this._pagesData.length - 1;
      }
      
      private function updatePagesBtn() : void
      {
         if(this._maxPagesLen > 1)
         {
            if(!this._prevPageBtn)
            {
               this._prevPageBtn = App.utils.classFactory.getComponent(Linkages.PAGINATOR_PAGE_SHIFT_BTN,PaginationPageButton);
               this._prevPageBtn.addEventListener(ButtonEvent.CLICK,this.onPrevPageBtnClickHandler);
               this._prevPageBtn.setImage(RES_ICONS.MAPS_ICONS_LIBRARY_ARROW_NAV_LEFT);
               this._prevPageBtn.name = TO_PREV_PAGE_BTN_NAME;
               this._holder.addChild(this._prevPageBtn);
            }
            if(!this._nextPageBtn)
            {
               this._nextPageBtn = App.utils.classFactory.getComponent(Linkages.PAGINATOR_PAGE_SHIFT_BTN,PaginationPageButton);
               this._nextPageBtn.addEventListener(ButtonEvent.CLICK,this.onNextPageBtnClickHandler);
               this._nextPageBtn.setImage(RES_ICONS.MAPS_ICONS_LIBRARY_ARROW_NAV_RIGHT);
               this._nextPageBtn.name = TO_NEXT_PAGE_BTN_NAME;
               this._holder.addChild(this._nextPageBtn);
            }
            this._hasPagesBtns = true;
            this.layoutPageBtns();
         }
         else
         {
            this.clearPagesBtns();
            this._hasPagesBtns = false;
         }
      }
      
      private function layoutPageBtns() : void
      {
         var _loc1_:int = 0;
         if(this._hasPagesBtns)
         {
            if(this._isCenterPages && this._paginatorPos)
            {
               _loc1_ = !!this._prevPageBtn.visible ? int(-(this._prevPageBtn.width + PAGE_BUTTON_RIGHT_X_SHIFT)) : int(0);
               if(this._nextPageBtn.visible)
               {
                  _loc1_ += this._nextPageBtn.width + PAGE_BUTTON_RIGHT_X_SHIFT;
               }
               this._pageButtons.x = this._paginatorPos.x - (this._pageButtons.actualWidth + _loc1_ >> 1) + PAGINATOR_X_SHIFT;
            }
            this._prevPageBtn.x = this._pageButtons.x - this._prevPageBtn.width - PAGE_BUTTON_LEFT_X_SHIFT | 0;
            this._nextPageBtn.x = this._pageButtons.x + this._pageButtons.width + PAGE_BUTTON_RIGHT_X_SHIFT | 0;
            this._nextPageBtn.y = this._prevPageBtn.y = this._pageButtons.y + PAGE_BUTTONS_Y_SHIFT | 0;
         }
      }
      
      private function clearPagesBtns() : void
      {
         if(this._prevPageBtn)
         {
            this._prevPageBtn.removeEventListener(ButtonEvent.CLICK,this.onPrevPageBtnClickHandler);
            this._holder.removeChild(this._prevPageBtn);
            this._prevPageBtn.dispose();
            this._prevPageBtn = null;
         }
         if(this._nextPageBtn)
         {
            this._nextPageBtn.removeEventListener(ButtonEvent.CLICK,this.onNextPageBtnClickHandler);
            this._holder.removeChild(this._nextPageBtn);
            this._nextPageBtn.dispose();
            this._nextPageBtn = null;
         }
      }
      
      private function switchPage(param1:int, param2:int) : void
      {
         var _loc3_:Button = null;
         var _loc4_:Button = null;
         if(this._currentPageIndex != param1 && param1 >= 0 && param1 < this._maxPagesLen)
         {
            this._currentPageIndex = param1;
            _loc3_ = this._buttonGroup.selectedButton;
            if(param2 == Values.DEFAULT_INT)
            {
               param2 = this._currentPageIndex * this._maxElementsPerPage;
            }
            this._pageButtons.ensureIndexVisible(param2);
            this._pageButtons.validateNow();
            this._currentMissionIndex = param2;
            this.onPageUpdate();
            _loc4_ = this._buttonGroup.selectedButton;
            if(_loc3_ == _loc4_)
            {
               this.onMissionHasChanged();
            }
         }
      }
      
      private function onPageUpdate() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._pagesData.length > this._currentMissionIndex)
         {
            _loc2_ = this._buttonGroup.length;
            _loc3_ = 0;
            while(_loc3_ != _loc2_)
            {
               Button(this._buttonGroup.getButtonAt(_loc3_)).invalidateState();
               _loc3_++;
            }
         }
         var _loc1_:int = this._pageButtons.getRendererIndex(this._currentMissionIndex);
         this._buttonGroup.setSelectedButtonByIndex(_loc1_);
      }
      
      private function updateControlsStates() : void
      {
         var _loc1_:Boolean = false;
         this._arrowLeftBtn.enabled = this._currentMissionIndex > this.getFirstMissionIndex();
         this._arrowRightBtn.enabled = this._currentMissionIndex < this.getLastMissionIndex();
         if(this._hideDisabledArrows)
         {
            _loc1_ = this._pagesData.length > 0;
            this._arrowLeftBtn.visible = this._arrowLeftBtn.enabled && _loc1_;
            this._arrowRightBtn.visible = this._arrowRightBtn.enabled && _loc1_;
         }
         if(this._hasPagesBtns)
         {
            this._nextPageBtn.visible = this._currentPageIndex + 1 < this._maxPagesLen;
            this._prevPageBtn.visible = this._currentPageIndex > 0;
            this.updatePageBtns();
            this.layoutPageBtns();
         }
      }
      
      private function removeListeners() : void
      {
         this._pageButtons.removeEventListener(PaginationGroupEvent.GROUP_CHANGED,this.onPageButtonsGroupChangedHandler);
         this._arrowLeftBtn.removeEventListener(ButtonEvent.CLICK,this.onArrowLeftBtnClickHandler);
         this._arrowRightBtn.removeEventListener(ButtonEvent.CLICK,this.onArrowRightBtnClickHandler);
         this._buttonGroup.removeEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
         this._arrowLeftBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
         this._arrowRightBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
         this._arrowLeftBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
         this._arrowRightBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
      }
      
      private function onArrowClick(param1:ISoundButtonEx) : void
      {
         App.utils.scheduler.scheduleTask(this.afterArrowClickCallback,AFTER_ARROW_CLICK_CALL_CALLBACK_DELAY,param1);
      }
      
      private function afterArrowClickCallback(param1:ISoundButtonEx) : void
      {
         var _loc2_:Boolean = param1.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true);
         if(_loc2_)
         {
            this.onArrowRollOver(param1);
         }
      }
      
      private function onArrowRollOver(param1:ISoundButtonEx) : void
      {
         var _loc2_:int = 0;
         if(this._allowPageChange)
         {
            if(param1.enabled)
            {
               _loc2_ = this._currentMissionIndex + (param1 == this._arrowLeftBtn ? -1 : 1);
               if(_loc2_ >= 0 && _loc2_ < this._pagesData.length)
               {
                  this.showArrowTooltip(_loc2_);
               }
            }
         }
      }
      
      private function onMissionHasChanged() : void
      {
         this.updateControlsStates();
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function onPageButtonsGroupChangedHandler(param1:PaginationGroupEvent) : void
      {
         this.updatePagesBtn();
      }
      
      private function onNextPageBtnClickHandler(param1:ButtonEvent) : void
      {
         this.switchPage(this._currentPageIndex + 1,Values.DEFAULT_INT);
      }
      
      private function onPrevPageBtnClickHandler(param1:ButtonEvent) : void
      {
         this.switchPage(this._currentPageIndex - 1,Values.DEFAULT_INT);
      }
      
      private function onArrowRightBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this._allowPageChange && this._arrowRightBtn.enabled)
         {
            this.onArrowClick(ISoundButtonEx(param1.target));
            this.arrowRightBtnClickHandler();
         }
      }
      
      private function onArrowLeftBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this._allowPageChange && this._arrowLeftBtn.enabled)
         {
            this.onArrowClick(ISoundButtonEx(param1.target));
            this.arrowLeftBtnClickHandler();
         }
      }
      
      private function onArrowMouseRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
         this.onArrowRollOver(_loc2_);
      }
      
      private function onArrowMouseRollOutHandler(param1:MouseEvent) : void
      {
         App.utils.scheduler.cancelTask(this.afterArrowClickCallback);
      }
      
      private function onButtonGroupChangeHandler(param1:Event) : void
      {
         if(this._allowPageChange)
         {
            this.setPageIndex(PaginationDetailsNumButton(this._buttonGroup.selectedButton).pageIndex);
            this.onMissionHasChanged();
         }
      }
      
      public function set allowPageChange(param1:Boolean) : void
      {
         if(param1 != this._allowPageChange)
         {
            this._allowPageChange = param1;
            this._pageButtons.mouseEnabled = this._pageButtons.mouseChildren = param1;
            this._arrowRightBtn.mouseEnabled = this._arrowRightBtn.mouseChildren = param1;
            this._arrowLeftBtn.mouseEnabled = this._arrowLeftBtn.mouseChildren = param1;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
