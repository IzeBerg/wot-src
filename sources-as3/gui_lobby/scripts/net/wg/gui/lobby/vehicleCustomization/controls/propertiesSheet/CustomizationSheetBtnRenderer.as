package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import fl.motion.easing.Sine;
   import flash.geom.Point;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet.CustomizationPropertiesSheetRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.CustomizationSheetRendererEvent;
   import net.wg.infrastructure.managers.ISoundManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationSheetBtnRenderer extends CustomizationSheetRendererBase
   {
      
      private static const ANIMATION_DELAY:int = 200;
      
      private static const FINISH_POSITIONS:Vector.<Point> = new <Point>[new Point(33,-10),new Point(-115,31),new Point(-115,-54),new Point(-263,-10)];
      
      private static const START_POSITIONS:Vector.<Point> = new <Point>[new Point(23,-10),new Point(-115,21),new Point(-115,-44),new Point(-263,0)];
      
      private static const ACTION_REMOVE_ONE:int = 2;
      
      private static const ACTION_REMOVE_FROM_ALL_PARTS:int = 6;
       
      
      public var tfAnimated:TextFieldAnimated = null;
      
      protected var model:CustomizationPropertiesSheetRendererVO = null;
      
      private var _sound:ISoundManager;
      
      private var _startPositionPoint:Point;
      
      private var _finishPositionPoint:Point;
      
      private var _currentTween:Tween = null;
      
      public function CustomizationSheetBtnRenderer()
      {
         this._sound = App.soundMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tfAnimated.mouseEnabled = this.tfAnimated.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.tfAnimated = null;
         this._sound = null;
         this._startPositionPoint = null;
         this._finishPositionPoint = null;
         if(this.model)
         {
            this.model.dispose();
            this.model = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.model && isInvalid(InvalidationType.DATA))
         {
            this.tfAnimated.setText(this.model.actionBtnLabel,isActionTheSame,animatedTransition);
         }
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.model = new CustomizationPropertiesSheetRendererVO(param1);
         invalidateData();
      }
      
      override public function setInitState() : void
      {
         this.tfAnimated.alpha = 0;
      }
      
      override public function onOverHandler() : void
      {
         super.onOverHandler();
         if(!layoutIdApplied)
         {
            return;
         }
         this.tfAnimated.x = this._startPositionPoint.x;
         this.tfAnimated.y = this._startPositionPoint.y;
         this.setTween(new Tween(ANIMATION_DELAY,this.tfAnimated,{
            "x":this._finishPositionPoint.x,
            "y":this._finishPositionPoint.y,
            "alpha":1
         },{
            "ease":Sine.easeIn,
            "onComplete":this.clearTween
         }));
         this._sound.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,Values.EMPTY_STR);
      }
      
      override public function onOutHandler() : void
      {
         super.onOutHandler();
         if(!layoutIdApplied)
         {
            return;
         }
         this.setTween(new Tween(ANIMATION_DELAY,this.tfAnimated,{
            "x":this._startPositionPoint.x,
            "y":this._startPositionPoint.y,
            "alpha":0
         },{
            "ease":Sine.easeOut,
            "onComplete":this.clearTween
         }));
         this._sound.playControlsSnd(SoundManagerStates.SND_OUT,SoundTypes.CUSTOMIZATION_DEFAULT,Values.EMPTY_STR);
      }
      
      private function setTween(param1:Tween) : void
      {
         this.clearTween();
         this._currentTween = param1;
         param1.paused = false;
      }
      
      private function clearTween() : void
      {
         if(this._currentTween)
         {
            this._currentTween.paused = true;
            this._currentTween.dispose();
            this._currentTween = null;
         }
      }
      
      override public function setLayout(param1:int) : void
      {
         super.setLayout(param1);
         this.tfAnimated.layoutId = currentLayoutId;
      }
      
      override protected function applyLayoutId() : void
      {
         super.applyLayoutId();
         this._finishPositionPoint = FINISH_POSITIONS[currentLayoutId - 1];
         this._startPositionPoint = START_POSITIONS[currentLayoutId - 1];
         this.tfAnimated.x = this._startPositionPoint.x;
         this.tfAnimated.y = this._startPositionPoint.y;
         this.tfAnimated.alpha = 0;
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
      
      override public function onClickHandler() : void
      {
         super.onClickHandler();
         var _loc1_:String = SoundTypes.CUSTOMIZATION_DEFAULT;
         if(this.model.actionType == ACTION_REMOVE_ONE || this.model.actionType == ACTION_REMOVE_FROM_ALL_PARTS)
         {
            _loc1_ = SoundTypes.CUSTOMIZATION_REMOVE;
         }
         this._sound.playControlsSnd(SoundManagerStates.SND_PRESS,_loc1_,Values.EMPTY_STR);
         this.dispatchClickAction();
      }
      
      protected function dispatchClickAction() : void
      {
         dispatchEvent(new CustomizationSheetRendererEvent(CustomizationSheetRendererEvent.ACTION_BTN_CLICK,this.model.actionType));
      }
   }
}
