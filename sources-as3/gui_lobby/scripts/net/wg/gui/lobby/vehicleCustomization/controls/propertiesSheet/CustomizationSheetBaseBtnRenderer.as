package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import fl.motion.easing.Exponential;
   import fl.motion.easing.Quintic;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.controls.CustomizationRadialButton;
   import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetButtonsRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationSheetBaseBtnRenderer extends CustomizationSheetRendererBase
   {
      
      private static const ANIMATION_INVALIDATE:String = "animation";
      
      private static const ANIMATION_DURATION:int = 400;
      
      private static const ANIMATION_HIDE_DURATION:int = 200;
      
      private static const ANIMATION_ROTATION:int = 45;
      
      private static const ANIMATION_DELAY_SCHEDULER:int = 50;
       
      
      public var btn0:CustomizationRadialButton = null;
      
      public var btn1:CustomizationRadialButton = null;
      
      public var btn2:CustomizationRadialButton = null;
      
      protected var btns:Vector.<CustomizationRadialButton> = null;
      
      protected var model:CustomizationPropertiesSheetButtonsRendererVO = null;
      
      private var _visibleAnimation:Boolean = false;
      
      private var _targetPositions:Vector.<Point>;
      
      private var _tweens:Vector.<Tween>;
      
      private var _shownElements:int = 0;
      
      private var _alreadyShow:Boolean = true;
      
      private var _rightPos:Vector.<Point>;
      
      private var _bottomPos:Vector.<Point>;
      
      private var _topPos:Vector.<Point>;
      
      private var _leftPos:Vector.<Point>;
      
      private var _layouts:Array;
      
      public function CustomizationSheetBaseBtnRenderer()
      {
         this._targetPositions = new Vector.<Point>(0);
         this._tweens = new Vector.<Tween>(0);
         this._rightPos = new <Point>[new Point(37,-30),new Point(65,0),new Point(37,30)];
         this._bottomPos = new <Point>[new Point(-30,37),new Point(0,65),new Point(30,37)];
         this._topPos = new <Point>[new Point(-30,-37),new Point(0,-65),new Point(30,-37)];
         this._leftPos = new <Point>[new Point(-37,-30),new Point(-65,0),new Point(-37,30)];
         this._layouts = [this._rightPos,this._bottomPos,this._topPos,this._leftPos];
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = mouseChildren = false;
         this.prepareBtns();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.btns = new <CustomizationRadialButton>[this.btn0,this.btn1,this.btn2];
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.model = new CustomizationPropertiesSheetButtonsRendererVO(param1);
         invalidateData();
      }
      
      private function prepareBtns() : void
      {
         var _loc1_:int = this.btns.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.prepareBtn(this.btns[_loc2_]);
            _loc2_++;
         }
      }
      
      override public function setLayout(param1:int) : void
      {
         super.setLayout(param1);
         this.clearTweens();
         this._targetPositions = this._layouts[param1 - 1];
      }
      
      protected function prepareBtn(param1:CustomizationRadialButton) : void
      {
         param1.allowDeselect = false;
         param1.toggle = true;
         param1.toggleEnable = true;
         param1.soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
         param1.alpha = 0;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(enabled && this.model && isInvalid(InvalidationType.DATA))
         {
            this.setButtonsData();
         }
         if(isInvalid(ANIMATION_INVALIDATE))
         {
            _loc1_ = 0;
            this.clearTweens();
            if(this._visibleAnimation)
            {
               mouseEnabled = mouseChildren = true;
               this._alreadyShow = true;
               this._shownElements = this.btns.length;
               dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_RADIAL_SMALL));
               _loc1_ = 0;
               while(_loc1_ < this._shownElements)
               {
                  this.animationShow(_loc1_);
                  _loc1_++;
               }
            }
            else if(this._alreadyShow)
            {
               this._shownElements = this.btns.length;
               _loc1_ = 0;
               while(_loc1_ < this._shownElements)
               {
                  this.animationHide(_loc1_);
                  _loc1_++;
               }
            }
         }
      }
      
      override public function setInitState() : void
      {
         super.onOutHandler();
         this.setVisibility(false);
      }
      
      override public function onOutHandler() : void
      {
         super.onOutHandler();
         this.setVisibility(false);
      }
      
      override public function onOverHandler() : void
      {
         super.onOverHandler();
         this.setVisibility(true);
      }
      
      override protected function onDisabledOnMouseOver() : void
      {
         super.onDisabledOnMouseOver();
         this.onOutHandler();
      }
      
      override protected function onEnabledOnMouseOver() : void
      {
         super.onEnabledOnMouseOver();
         this.onOverHandler();
      }
      
      private function setVisibility(param1:Boolean) : void
      {
         if(this._visibleAnimation != param1)
         {
            this._visibleAnimation = param1;
            App.utils.scheduler.cancelTask(invalidate);
            if(param1)
            {
               App.utils.scheduler.scheduleTask(invalidate,ANIMATION_DELAY_SCHEDULER,ANIMATION_INVALIDATE);
            }
            else
            {
               invalidate(ANIMATION_INVALIDATE);
            }
         }
      }
      
      private function elementsHide() : void
      {
         this._shownElements -= 1;
         if(this._shownElements <= 0)
         {
            this._shownElements = 0;
            mouseEnabled = mouseChildren = false;
            this._alreadyShow = false;
            this.clearTweens();
         }
      }
      
      private function clearTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
      }
      
      private function animationShow(param1:int) : void
      {
         var _loc2_:MovieClip = this.btns[param1];
         _loc2_.x = _loc2_.y = _loc2_.alpha = 0;
         _loc2_.rotation = ANIMATION_ROTATION;
         this._tweens.push(new Tween(ANIMATION_DURATION,_loc2_,{
            "x":this._targetPositions[param1].x,
            "y":this._targetPositions[param1].y,
            "alpha":1,
            "rotation":0
         },{
            "ease":Quintic.easeOut,
            "onComplete":this.clearTweens
         }));
      }
      
      private function animationHide(param1:int) : void
      {
         var _loc2_:MovieClip = this.btns[param1];
         this._tweens.push(new Tween(ANIMATION_HIDE_DURATION,_loc2_,{
            "x":0,
            "y":0,
            "alpha":0,
            "rotation":ANIMATION_ROTATION
         },{
            "ease":Exponential.easeIn,
            "onComplete":this.elementsHide
         }));
      }
      
      private function setButtonsData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.model.btnsBlockVO)
         {
            _loc1_ = this.btns.length;
            _loc2_ = this.model.btnsBlockVO.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(_loc3_ < _loc2_)
               {
                  this.btns[_loc3_].setVO(this.model.btnsBlockVO[_loc3_]);
                  this.btns[_loc3_].toggleIndicatorEnable(this.model.multiselectionEnable);
                  this.btns[_loc3_].visible = true;
               }
               else
               {
                  this.btns[_loc3_].visible = false;
               }
               _loc3_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(invalidate);
         this._targetPositions.splice(0,this._targetPositions.length);
         this._targetPositions = null;
         this._layouts.splice(0,this._layouts.length);
         this._layouts = null;
         this._rightPos.splice(0,this._rightPos.length);
         this._rightPos = null;
         this._leftPos.splice(0,this._leftPos.length);
         this._leftPos = null;
         this._bottomPos.splice(0,this._bottomPos.length);
         this._bottomPos = null;
         this._topPos.splice(0,this._topPos.length);
         this._topPos = null;
         this.clearTweens();
         this._tweens = null;
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         this.btns.splice(0,this.btns.length);
         this.btns = null;
         this.btn0.dispose();
         this.btn0 = null;
         this.btn1.dispose();
         this.btn1 = null;
         this.btn2.dispose();
         this.btn2 = null;
         super.onDispose();
      }
   }
}
