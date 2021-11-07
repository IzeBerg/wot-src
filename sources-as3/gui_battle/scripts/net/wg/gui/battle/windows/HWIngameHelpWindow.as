package net.wg.gui.battle.windows
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.paginator.PaginationDetailsNumButton;
   import net.wg.gui.components.paginator.PaginationGroup;
   import net.wg.gui.components.paginator.PaginatorArrowsController;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.infrastructure.base.meta.IHWIngameHelpWindowMeta;
   import net.wg.infrastructure.base.meta.impl.HWIngameHelpWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class HWIngameHelpWindow extends HWIngameHelpWindowMeta implements IHWIngameHelpWindowMeta
   {
      
      private static const WINDOW_OFFSET:int = 23;
      
      private static const LOADER_WIDTH:int = 1024;
      
      private static const LOADER_HEIGHT:int = 600;
      
      private static const HELP_PAGES_GROUP:String = "HelpPagesGroup";
       
      
      public var closeBtn:CloseButtonText = null;
      
      public var pageTitleTF:TextField = null;
      
      public var btnLeft:SoundButtonEx = null;
      
      public var btnRight:SoundButtonEx = null;
      
      public var backgroundContainer:MovieClip = null;
      
      public var bottomBg:BattleAtlasSprite = null;
      
      public var background:BattleAtlasSprite = null;
      
      public var pageButtons:PaginationGroup = null;
      
      private var _tutorialPageList:Vector.<TutorialPageContainer>;
      
      private var _picIndex:int = 0;
      
      private var _data:Vector.<BCTutorialPageVO> = null;
      
      private var _pageController:PaginatorArrowsController = null;
      
      private var _pages:DataProvider = null;
      
      public function HWIngameHelpWindow()
      {
         this._tutorialPageList = new Vector.<TutorialPageContainer>();
         super();
         showWindowBgForm = false;
         showWindowBg = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.label = INGAME_HELP.BATTLECONTROLS_CLOSEBTNLABEL;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.pageTitleTF.text = INGAME_HELP.DETAILSHELP_DEFAULT_TITLE;
         this.bottomBg.imageName = BATTLEATLAS.HELP_WINDOW_BOTTOM_BG;
         this.background.imageName = BATTLEATLAS.HELP_WINDOW_BG;
         updateStage(App.appWidth,App.appHeight);
         window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
         this._pageController = new PaginatorArrowsController(this,this.pageButtons,this.btnLeft,this.btnRight,HELP_PAGES_GROUP,Values.ZERO,false,Values.ZERO,true);
         this._pageController.addEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:PaginatorPageNumVO = null;
         var _loc2_:Point = null;
         super.draw();
         if(geometry && window && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            window.x = App.appWidth - window.getBackground().width >> 1;
            window.y = (App.appHeight - window.getBackground().height >> 1) - WINDOW_OFFSET;
         }
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.createImagesList();
            this.updateBackgroundRenderer();
         }
         if(this._pages != null && isInvalid(InvalidationType.DATA))
         {
            this._pageController.setPages(this._pages);
            for each(_loc1_ in this._pages)
            {
               if(_loc1_.selected)
               {
                  this._pageController.setPageIndex(_loc1_.pageIndex);
                  break;
               }
            }
            _loc2_ = new Point(width >> 1,this.pageButtons.y);
            this._pageController.setPositions(_loc2_);
         }
      }
      
      override protected function onDispose() : void
      {
         window.removeEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.pageTitleTF = null;
         this.btnLeft.dispose();
         this.btnLeft = null;
         this.btnRight.dispose();
         this.btnRight = null;
         this.backgroundContainer = null;
         this.bottomBg = null;
         this.background = null;
         this.pageButtons.dispose();
         this.pageButtons = null;
         this._pageController.removeEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
         this._pageController.dispose();
         this._pageController = null;
         this.disposeBackgroundRenderers();
         this._tutorialPageList = null;
         this._data = null;
         this._pages = null;
         super.onDispose();
      }
      
      override protected function setData(param1:Vector.<BCTutorialPageVO>) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setPaginatorData(param1:DataProvider) : void
      {
         this._pages = param1;
         invalidateData();
      }
      
      private function disposeBackgroundRenderers() : void
      {
         var _loc3_:TutorialPageContainer = null;
         var _loc1_:int = this._tutorialPageList.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._tutorialPageList[_loc2_];
            _loc3_.removeLoaderListener();
            _loc3_.dispose();
            _loc2_++;
         }
         this._tutorialPageList.splice(0,this._tutorialPageList.length);
      }
      
      private function createImagesList() : void
      {
         var _loc3_:BCTutorialPageVO = null;
         var _loc4_:TutorialPageContainer = null;
         if(this._tutorialPageList.length)
         {
            this.disposeBackgroundRenderers();
         }
         var _loc1_:int = this._data.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._data[_loc2_];
            _loc4_ = App.utils.classFactory.getComponent(_loc3_.rendererLinkage,TutorialPageContainer);
            _loc4_.addLoaderListener();
            _loc4_.setLoaderSize(LOADER_WIDTH,LOADER_HEIGHT);
            _loc4_.setData(_loc3_);
            this._tutorialPageList.push(_loc4_);
            _loc2_++;
         }
      }
      
      private function updateBackgroundRenderer() : void
      {
         if(this._tutorialPageList.length)
         {
            if(this.backgroundContainer.numChildren > 0)
            {
               this.backgroundContainer.removeChildAt(0);
            }
            this.backgroundContainer.addChild(this._tutorialPageList[this._picIndex]);
         }
      }
      
      private function onPageControllerChangeHandler(param1:Event) : void
      {
         this._picIndex = PaginationDetailsNumButton(this._pageController.getSelectedButton()).pageIndex;
         if(this._picIndex >= this._pages.length)
         {
            this._picIndex = this._pages.length - 1;
         }
         if(this._picIndex < 0)
         {
            this._picIndex = 0;
         }
         this.updateBackgroundRenderer();
      }
      
      private function onWindowScaleYChangedHandler(param1:WindowEvent) : void
      {
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         handleWindowClose();
      }
   }
}
