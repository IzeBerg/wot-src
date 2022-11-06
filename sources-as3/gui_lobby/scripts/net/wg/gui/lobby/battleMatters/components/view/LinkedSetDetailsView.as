package net.wg.gui.lobby.battleMatters.components.view
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.controls.BCLobbyRectangleHint;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.paginator.PaginatorArrowsController;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.battleMatters.components.LinkedSetAward;
   import net.wg.gui.lobby.battleMatters.components.LinkedSetVideo;
   import net.wg.gui.lobby.battleMatters.components.MissionsPaginator;
   import net.wg.gui.lobby.battleMatters.data.LinkedSetAwardVO;
   import net.wg.gui.lobby.battleMatters.data.LinkedSetDetailsOverlayVO;
   import net.wg.gui.lobby.battleMatters.data.LinkedSetDetailsVideoVO;
   import net.wg.infrastructure.base.meta.ILinkedSetDetailsOverlayMeta;
   import net.wg.infrastructure.base.meta.impl.LinkedSetDetailsOverlayMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   import scaleform.gfx.TextFieldEx;
   
   public class LinkedSetDetailsView extends LinkedSetDetailsOverlayMeta implements ILinkedSetDetailsOverlayMeta, IPopOverCaller
   {
      
      private static const AWARD_OFFSET:int = 80;
      
      private static const LABEL_MAIN:String = "main";
      
      private static const MOVIE_OFFSET:int = 65;
      
      private static const DATA_VIDEO:String = "dataVideo";
      
      private static const BUTTON_GROUP:String = "linkedSetButtons";
      
      private static const DETAILS_WIDTH:int = 752;
      
      private static const DETAILS_HEIGHT:int = 548;
      
      private static const PAGES_SPACING:int = -8;
      
      private static const ARROW_HORIZONTAL_GAP:int = 25;
      
      private static const PAGINATOR_Y_GAP:int = 16;
       
      
      public var titleTf:TextField = null;
      
      public var statusTf:TextField = null;
      
      public var infoTf:TextField = null;
      
      public var taskTf:TextField = null;
      
      public var descriptionTf:TextField = null;
      
      public var progressBar:IProgressBarAnim = null;
      
      public var btnStart:ISoundButtonEx = null;
      
      public var awards:Sprite = null;
      
      public var missionsPaginator:MissionsPaginator = null;
      
      public var arrowLeftBtn:ISoundButtonEx;
      
      public var arrowRightBtn:ISoundButtonEx;
      
      public var backOverlay:Sprite = null;
      
      public var back:UILoaderAlt = null;
      
      private var _data:LinkedSetDetailsOverlayVO = null;
      
      private var _dataVideo:LinkedSetDetailsVideoVO = null;
      
      private var _eventId:String = "";
      
      private var _hintStart:BCLobbyRectangleHint = null;
      
      private var _loaderMovie:Loader = null;
      
      private var _pageController:PaginatorArrowsController = null;
      
      private var _classFactory:IClassFactory;
      
      public function LinkedSetDetailsView()
      {
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._pageController = new PaginatorArrowsController(this,this.missionsPaginator,this.arrowLeftBtn,this.arrowRightBtn,BUTTON_GROUP,Values.ZERO,false,PAGES_SPACING);
         this._pageController.addEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setVerticalAlign(this.descriptionTf,TextFieldEx.VALIGN_BOTTOM);
         this.btnStart.addEventListener(ButtonEvent.CLICK,this.onBtnStartClickHandler);
         this._loaderMovie = new Loader();
         this._loaderMovie.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loaderMovie.x = 0;
         this._loaderMovie.y = MOVIE_OFFSET;
         addChild(this._loaderMovie);
         this.back.autoSize = false;
         this.arrowLeftBtn.x = 0 - this.arrowLeftBtn.width - ARROW_HORIZONTAL_GAP >> 0;
         this.arrowRightBtn.x = DETAILS_WIDTH + this.arrowLeftBtn.width + ARROW_HORIZONTAL_GAP >> 0;
         this.arrowLeftBtn.y = this.arrowRightBtn.y = Values.ZERO;
         var _loc1_:Point = new Point(DETAILS_WIDTH >> 1,DETAILS_HEIGHT + PAGINATOR_Y_GAP);
         this._pageController.setPositions(_loc1_);
      }
      
      override protected function setData(param1:LinkedSetDetailsOverlayVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setDataVideo(param1:LinkedSetDetailsVideoVO) : void
      {
         this._dataVideo = param1;
         invalidate(DATA_VIDEO);
      }
      
      override protected function setColorPages(param1:DataProvider) : void
      {
         this._pageController.setPages(param1);
      }
      
      override protected function draw() : void
      {
         var _loc1_:LinkedSetAward = null;
         var _loc2_:Vector.<LinkedSetAwardVO> = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:URLRequest = null;
         var _loc7_:LoaderContext = null;
         var _loc8_:DisplayObjectContainer = null;
         var _loc9_:LinkedSetVideo = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this._eventId = this._data.eventID;
            this.clearAwards();
            _loc2_ = this._data.awards;
            _loc3_ = _loc2_.length;
            _loc4_ = DETAILS_WIDTH - _loc3_ * AWARD_OFFSET >> 1;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc1_ = this._classFactory.getComponent(Linkages.LINKED_SET_AWARD_UI,LinkedSetAward);
               _loc1_.x = _loc4_;
               _loc4_ += AWARD_OFFSET;
               _loc1_.setData(_loc2_[_loc5_]);
               this.awards.addChild(_loc1_);
               _loc5_++;
            }
            this.titleTf.htmlText = this._data.title;
            this.statusTf.htmlText = this._data.status;
            this.infoTf.visible = StringUtils.isNotEmpty(this._data.info);
            if(this.infoTf.visible)
            {
               this.infoTf.htmlText = this._data.info;
            }
            this.taskTf.visible = StringUtils.isNotEmpty(this._data.task);
            if(this.taskTf.visible)
            {
               this.taskTf.htmlText = this._data.task;
            }
            this.btnStart.visible = StringUtils.isNotEmpty(this._data.btnStartLabel);
            if(this.btnStart.visible)
            {
               this.btnStart.label = this._data.btnStartLabel;
               this.addHintStart();
            }
            this.descriptionTf.htmlText = this._data.description;
            this.progressBar.visible = this._data.isProgressBar;
            if(this.progressBar.visible)
            {
               this.progressBar.setData(this._data.progressBarData);
            }
            this.backOverlay.visible = this._data.isBackOverlay;
            if(this._data.isMovie)
            {
               this._loaderMovie.visible = StringUtils.isNotEmpty(this._data.back);
               if(this._loaderMovie.visible)
               {
                  _loc6_ = new URLRequest(this._data.back);
                  _loc7_ = new LoaderContext(false,ApplicationDomain.currentDomain);
                  this._loaderMovie.unloadAndStop();
                  this._loaderMovie.load(_loc6_,_loc7_);
               }
               this.back.visible = false;
            }
            else
            {
               this.back.visible = StringUtils.isNotEmpty(this._data.back);
               if(this.back.visible)
               {
                  this.back.source = this._data.back;
               }
               this._loaderMovie.visible = false;
            }
         }
         if(this._loaderMovie && this._loaderMovie.content && isInvalid(DATA_VIDEO))
         {
            _loc8_ = DisplayObjectContainer(this._loaderMovie.content);
            _loc9_ = LinkedSetVideo(_loc8_.getChildByName(LABEL_MAIN));
            _loc9_.setData(this._dataVideo);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.clearAwards();
         this.btnStart.removeEventListener(ButtonEvent.CLICK,this.onBtnStartClickHandler);
         this._pageController.removeEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
         this._loaderMovie.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this._loaderMovie.unloadAndStop(true);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._pageController.dispose();
         this._pageController = null;
         this.titleTf = null;
         this.statusTf = null;
         this.infoTf = null;
         this.taskTf = null;
         this.descriptionTf = null;
         this.progressBar.dispose();
         this.progressBar = null;
         this.removeHintStart();
         this.btnStart.dispose();
         this.btnStart = null;
         this.awards = null;
         this.missionsPaginator.dispose();
         this.missionsPaginator = null;
         this.backOverlay = null;
         removeChild(this._loaderMovie);
         this._loaderMovie = null;
         this.back.dispose();
         this.back = null;
         this._data = null;
         this._dataVideo = null;
         this._classFactory = null;
         this.arrowLeftBtn.dispose();
         this.arrowLeftBtn = null;
         this.arrowRightBtn.dispose();
         this.arrowRightBtn = null;
         super.onDispose();
      }
      
      public function as_setPage(param1:int) : void
      {
         this._pageController.setPageIndex(param1);
      }
      
      public function getHitArea() : DisplayObject
      {
         return DisplayObject(this.btnStart);
      }
      
      public function getTargetButton() : DisplayObject
      {
         return DisplayObject(this.btnStart);
      }
      
      private function addHintStart() : void
      {
         if(this._hintStart == null)
         {
            this._hintStart = this._classFactory.getComponent(Linkages.LOBBY_RECTANGLE_HINT_UI,BCLobbyRectangleHint);
            this._hintStart.x = this.btnStart.x;
            this._hintStart.y = this.btnStart.y;
            this._hintStart.setProperties(this.btnStart.width,this.btnStart.height,true);
            addChild(this._hintStart);
         }
      }
      
      private function removeHintStart() : void
      {
         if(this._hintStart != null)
         {
            removeChild(this._hintStart);
            this._hintStart.dispose();
            this._hintStart = null;
         }
      }
      
      private function clearAwards() : void
      {
         while(this.awards.numChildren)
         {
            this.awards.removeChildAt(0);
         }
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         invalidate(DATA_VIDEO);
      }
      
      private function onBtnStartClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            startClickS(this._eventId);
         }
      }
      
      private function onPageControllerChangeHandler(param1:Event) : void
      {
         setPageS(this._pageController.getPageIndex());
      }
   }
}
