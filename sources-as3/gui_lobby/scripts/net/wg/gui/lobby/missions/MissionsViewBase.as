package net.wg.gui.lobby.missions
{
   import fl.motion.easing.Cubic;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.gui.components.advanced.events.DummyEvent;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.missions.data.MissionsPackVO;
   import net.wg.gui.lobby.missions.event.MissionViewEvent;
   import net.wg.infrastructure.base.meta.IMissionsViewBaseMeta;
   import net.wg.infrastructure.base.meta.impl.MissionsViewBaseMeta;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.motion.Tween;
   
   public class MissionsViewBase extends MissionsViewBaseMeta implements IMissionsViewBaseMeta, IViewStackContent
   {
      
      protected static const BIG_FADE_IN_DELAY:Number = 700;
      
      protected static const SMALL_FADE_IN_DELAY:Number = 250;
      
      private static const FADE_IN_DURATION:Number = 1500;
      
      private static const INV_BACKGROUND_POSITION:String = "InvBackgroundPosition";
      
      private static const ORIGINAL_BACKGROUND_ASPECT_RATIO:Number = 2;
       
      
      public var bgLoader:UILoaderAlt;
      
      public var dummy:IDummy;
      
      protected var _hasBeenShownBefore:Boolean = false;
      
      protected var _fadeInTween:Tween;
      
      public function MissionsViewBase()
      {
         super();
         addEventListener(ComponentEvent.SHOW,this.onShowHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.bgLoader)
         {
            this.bgLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
            this.bgLoader.autoSize = false;
         }
         this.iniDummy();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ComponentEvent.SHOW,this.onShowHandler);
         if(this.dummy)
         {
            this.dummy.removeEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
            this.dummy.dispose();
            this.dummy = null;
         }
         if(this.bgLoader)
         {
            this.bgLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
            this.bgLoader.dispose();
            this.bgLoader = null;
         }
         this.clearFadeInTween();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateDummySize();
            invalidate(INV_BACKGROUND_POSITION);
         }
         if(isInvalid(INV_BACKGROUND_POSITION))
         {
            _loc1_ = _width / _height > ORIGINAL_BACKGROUND_ASPECT_RATIO;
            this.updateBgLoaderSize(!!_loc1_ ? int(_width) : int(_height * ORIGINAL_BACKGROUND_ASPECT_RATIO),!!_loc1_ ? int(_width / ORIGINAL_BACKGROUND_ASPECT_RATIO) : int(_height));
         }
      }
      
      override protected function showDummy(param1:DummyVO) : void
      {
         if(this.dummy)
         {
            this.dummy.setData(param1);
            this.setDummyVisible(true);
         }
      }
      
      public function as_hideDummy() : void
      {
         this.setDummyVisible(false);
      }
      
      public function as_setBackground(param1:String) : void
      {
         this.bgLoader.source = param1;
      }
      
      public function as_setWaitingVisible(param1:Boolean) : void
      {
         var _loc2_:MissionViewEvent = new MissionViewEvent(MissionViewEvent.SHOW_WAITING,true);
         _loc2_.isWaiting = param1;
         dispatchEvent(_loc2_);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function iniDummy() : void
      {
         if(this.dummy)
         {
            this.dummy.addEventListener(DummyEvent.CLICK,this.onDummyClickHandler);
         }
      }
      
      protected function updateDummySize() : void
      {
         if(this.dummy)
         {
            this.dummy.width = _width;
            this.dummy.height = _height;
         }
      }
      
      protected function getHeight() : int
      {
         return _height;
      }
      
      protected function handleShow() : void
      {
         this.clearFadeInTween();
         this.playFadeInTween();
      }
      
      protected function setFadeInTween(param1:int) : void
      {
         this._fadeInTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
            "paused":false,
            "ease":Cubic.easeOut,
            "delay":param1,
            "onComplete":null
         });
         this._fadeInTween.fastTransform = false;
      }
      
      protected function playFadeInTween() : void
      {
         alpha = 0;
         var _loc1_:int = !!this._hasBeenShownBefore ? int(SMALL_FADE_IN_DELAY) : int(BIG_FADE_IN_DELAY);
         this.setFadeInTween(_loc1_);
         this._hasBeenShownBefore = true;
      }
      
      protected function setDummyVisible(param1:Boolean) : void
      {
         if(this.dummy)
         {
            this.dummy.visible = param1;
         }
      }
      
      private function clearFadeInTween() : void
      {
         if(this._fadeInTween)
         {
            this._fadeInTween.dispose();
            this._fadeInTween = null;
         }
      }
      
      protected function updateBgLoaderSize(param1:int, param2:int) : void
      {
         if(this.bgLoader)
         {
            this.bgLoader.width = param1;
            this.bgLoader.height = param2;
            this.bgLoader.x = _width - param1 >> 1;
            this.bgLoader.y = _height - param2 >> 1;
         }
      }
      
      protected function get dataProviderClass() : Class
      {
         return MissionsPackVO;
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         invalidate(INV_BACKGROUND_POSITION);
      }
      
      private function onDummyClickHandler(param1:DummyEvent) : void
      {
         dummyClickedS(param1.clickType);
      }
      
      private function onShowHandler(param1:ComponentEvent) : void
      {
         this.handleShow();
      }
   }
}
