package net.wg.gui.battle.windows
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.eventBattle.views.loading.containers.LoadingPageContainer;
   import net.wg.gui.battle.eventBattle.views.loading.containers.StepperContainer;
   import net.wg.gui.battle.eventBattle.views.loading.data.EventLoadingPageVO;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.infrastructure.base.meta.IMapsTrainingIngameHelpWindowMeta;
   import net.wg.infrastructure.base.meta.impl.MapsTrainingIngameHelpWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class MapsTrainingIngameHelpWindow extends MapsTrainingIngameHelpWindowMeta implements IMapsTrainingIngameHelpWindowMeta
   {
      
      private static const WINDOW_OFFSET:int = 23;
      
      private static const LOADER_WIDTH:int = 1024;
      
      private static const LOADER_HEIGHT:int = 576;
       
      
      public var closeBtn:CloseButtonText = null;
      
      public var pageTitleTF:TextField = null;
      
      public var btnLeft:SoundButtonEx = null;
      
      public var btnRight:SoundButtonEx = null;
      
      public var backgroundContainer:MovieClip = null;
      
      public var stepperBar:StepperContainer = null;
      
      public var bottomBg:BattleAtlasSprite = null;
      
      public var background:BattleAtlasSprite = null;
      
      private var _tutorialPageList:Vector.<LoadingPageContainer>;
      
      private var _picIndex:int = 0;
      
      private var _data:Vector.<EventLoadingPageVO> = null;
      
      public function MapsTrainingIngameHelpWindow()
      {
         this._tutorialPageList = new Vector.<LoadingPageContainer>();
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
         this.btnLeft.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
      }
      
      override protected function draw() : void
      {
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
      }
      
      private function disposeBackgroundRenderers() : void
      {
         var _loc3_:LoadingPageContainer = null;
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
         var _loc3_:EventLoadingPageVO = null;
         var _loc4_:LoadingPageContainer = null;
         if(this._tutorialPageList.length)
         {
            this.disposeBackgroundRenderers();
         }
         var _loc1_:int = this._data.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._data[_loc2_];
            _loc4_ = App.utils.classFactory.getComponent(_loc3_.rendererLinkage,LoadingPageContainer);
            _loc4_.addLoaderListener();
            _loc4_.setLoaderSize(LOADER_WIDTH,LOADER_HEIGHT);
            _loc4_.setData(_loc3_);
            this._tutorialPageList.push(_loc4_);
            _loc2_++;
         }
         if(_loc1_)
         {
            this.stepperBar.setCount(_loc1_);
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         this.btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
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
         this.stepperBar.dispose();
         this.stepperBar = null;
         this.bottomBg = null;
         this.background = null;
         this.disposeBackgroundRenderers();
         this._tutorialPageList = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function setData(param1:Vector.<EventLoadingPageVO>) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function onWindowScaleYChangedHandler(param1:WindowEvent) : void
      {
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         handleWindowClose();
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
            this.stepperBar.selectItem(this._picIndex);
         }
      }
      
      private function onButtonsClickHandler(param1:ButtonEvent) : void
      {
         if(param1.currentTarget == this.btnRight)
         {
            this._picIndex = this._picIndex < this._tutorialPageList.length - 1 ? int(this._picIndex + 1) : int(0);
         }
         else
         {
            this._picIndex = this._picIndex > 0 ? int(this._picIndex - 1) : int(this._tutorialPageList.length - 1);
         }
         this.updateBackgroundRenderer();
      }
   }
}
