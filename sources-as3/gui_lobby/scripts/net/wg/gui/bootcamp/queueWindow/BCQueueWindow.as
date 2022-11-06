package net.wg.gui.bootcamp.queueWindow
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   import net.wg.gui.bootcamp.data.BCTutorialPageVO;
   import net.wg.gui.bootcamp.queueWindow.data.BCQueueVO;
   import net.wg.gui.components.common.waiting.WaitingMc;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.meta.IBCQueueWindowMeta;
   import net.wg.infrastructure.base.meta.impl.BCQueueWindowMeta;
   import scaleform.clik.events.ButtonEvent;
   
   public class BCQueueWindow extends BCQueueWindowMeta implements IBCQueueWindowMeta
   {
      
      private static const SMALL_SCREEN_WIDTH:int = 1920;
      
      private static const SMALL_SCREEN_HEIGHT:int = 1080;
      
      private static const BACK_WIDTH_BIG:int = 3440;
      
      private static const BACK_WIDTH_SMALL:int = 2365;
      
      private static const BACK_HEIGHT_SMALL:int = 1930;
      
      private static const BACK_HEIGHT_BIG:int = 1380;
      
      private static const INTRO_IMAGE_WIDTH:int = 1920;
      
      private static const INTRO_IMAGE_HEIGHT:int = 1200;
      
      private static const BOTTOM_PADDING:int = 150;
      
      private static const INFO_OFFSET:int = 7;
      
      private static const DROP_SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(50,270,0,1,150,150,2);
      
      private static const DROP_SHADOW_FILTER_SCALED:DropShadowFilter = new DropShadowFilter(100,270,0,1,300,300,2);
       
      
      public var infoField:TextField;
      
      public var overlay:Sprite;
      
      public var waiting:WaitingMc;
      
      public var backgroundOverlay:Sprite;
      
      public var cancelBtn:ISoundButtonEx;
      
      public var background:UILoaderAlt;
      
      private var _backgroundContainer:Sprite;
      
      private var _tutorialPage:TutorialPageContainer;
      
      private var _useBigPictures:Boolean = false;
      
      private var _inited:Boolean = false;
      
      private var _introData:BCQueueVO;
      
      public function BCQueueWindow()
      {
         this._backgroundContainer = new Sprite();
         super();
      }
      
      public function as_setStatusText(param1:String) : void
      {
         this.waiting.setMessage(param1);
      }
      
      public function as_showCancelButton(param1:Boolean, param2:String, param3:String) : void
      {
         this.cancelBtn.label = param2;
         this.cancelBtn.visible = param1;
         this.infoField.text = param3;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.overlay.width = this.backgroundOverlay.width = param1;
         this.overlay.height = this.backgroundOverlay.height = param2;
         this.updatePosition();
      }
      
      override protected function setData(param1:BCQueueVO) : void
      {
         this._introData = param1;
         if(this._introData.showTutorialPages)
         {
            this.background.visible = false;
            this.createTutorialPage();
         }
         else
         {
            this.background.visible = true;
            this.background.source = this._introData.backgroundImage;
         }
         this.updatePosition();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addChildAt(this._backgroundContainer,1);
         this.cancelBtn.addEventListener(ButtonEvent.PRESS,this.onCancelBtnPressHandler);
         this.background.addEventListener(UILoaderEvent.COMPLETE,this.onBackgroundCompleteHandler,false,0,true);
         this.infoField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      private function onBackgroundCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updatePosition();
      }
      
      override protected function onDispose() : void
      {
         this.disposeBackgroundRenderer();
         this.overlay = null;
         this.infoField = null;
         this.waiting.dispose();
         this.waiting = null;
         this.backgroundOverlay = null;
         this._backgroundContainer = null;
         this._introData = null;
         this.background.removeEventListener(UILoaderEvent.COMPLETE,this.onBackgroundCompleteHandler);
         this.background.dispose();
         this.background = null;
         this.cancelBtn.removeEventListener(ButtonEvent.PRESS,this.onCancelBtnPressHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         super.onDispose();
      }
      
      private function updatePosition() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:int = App.appWidth;
         var _loc2_:int = App.appHeight;
         this.cancelBtn.x = _loc1_ - this.cancelBtn.width >> 1;
         var _loc3_:Boolean = _loc1_ >= SMALL_SCREEN_WIDTH && _loc2_ >= SMALL_SCREEN_HEIGHT;
         if(this._introData && this._introData.showTutorialPages)
         {
            if(this._useBigPictures != _loc3_ || !this._inited)
            {
               this._useBigPictures = _loc3_;
               this._inited = true;
               this.createTutorialPage();
            }
            this._backgroundContainer.x = -((!!this._useBigPictures ? BACK_WIDTH_BIG : BACK_WIDTH_SMALL) - _loc1_ >> 1);
            this._backgroundContainer.y = -((!!this._useBigPictures ? BACK_HEIGHT_SMALL : BACK_HEIGHT_BIG) - _loc2_ >> 1);
         }
         else
         {
            _loc4_ = _loc1_ / INTRO_IMAGE_WIDTH;
            _loc5_ = _loc2_ / INTRO_IMAGE_HEIGHT;
            _loc6_ = 1;
            if(_loc4_ > _loc5_)
            {
               _loc6_ = _loc5_;
            }
            else
            {
               _loc6_ = _loc4_;
            }
            this.background.width = INTRO_IMAGE_WIDTH * _loc6_;
            this.background.height = INTRO_IMAGE_HEIGHT * _loc6_;
            this.background.x = _loc1_ - INTRO_IMAGE_WIDTH * _loc6_ >> 1;
            this.background.y = _loc2_ - INTRO_IMAGE_HEIGHT * _loc6_ >> 1;
         }
         this.waiting.x = _loc1_ - this.waiting.width >> 1;
         this.waiting.y = _loc2_ - this.waiting.height >> 1;
         this.infoField.x = _loc1_ - this.infoField.width >> 1;
         this.infoField.y = this.waiting.y + this.waiting.height + INFO_OFFSET | 0;
         this.cancelBtn.x = _loc1_ - this.cancelBtn.width >> 1;
         this.cancelBtn.y = _loc2_ - BOTTOM_PADDING | 0;
         this.updateFiltersStrength();
      }
      
      private function createTutorialPage() : void
      {
         this.disposeBackgroundRenderer();
         var _loc1_:BCTutorialPageVO = !!this._useBigPictures ? this._introData.lessonPageBigData : this._introData.lessonPageSmallData;
         var _loc2_:TutorialPageContainer = App.utils.classFactory.getComponent(_loc1_.rendererLinkage,TutorialPageContainer);
         _loc2_.setData(_loc1_);
         this._tutorialPage = _loc2_;
         if(this._backgroundContainer.numChildren > 0)
         {
            this._backgroundContainer.removeChildAt(0);
         }
         this._backgroundContainer.addChild(this._tutorialPage);
      }
      
      private function disposeBackgroundRenderer() : void
      {
         if(this._tutorialPage)
         {
            this._tutorialPage.dispose();
            this._tutorialPage = null;
         }
      }
      
      private function onCancelBtnPressHandler(param1:ButtonEvent) : void
      {
         cancelS();
      }
      
      private function updateFiltersStrength() : void
      {
         this.waiting.filters = [App.stage.scaleX > 1 ? DROP_SHADOW_FILTER_SCALED : DROP_SHADOW_FILTER];
      }
   }
}
