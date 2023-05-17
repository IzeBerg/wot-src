package net.wg.gui.lobby.congrats
{
   import fl.motion.easing.Back;
   import fl.transitions.easing.Regular;
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.components.icons.TankTypeIco;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.components.CollectibleStatus;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class VehicleCongratulationAnimation extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const LEFT_TF_OFFSET:int = 16;
      
      private static const RIGHT_TF_OFFSET:int = -12;
      
      private static const TF_ELITE_EXTRA_OFFSET:int = 10;
      
      private static const VEHICLE_H_OFFSET:int = 40;
      
      private static const VEHICLE_V_OFFSET:int = 34;
      
      private static const VEHICLE_HIGHLIGHT_OFFSET:int = 80;
      
      private static const ANIMATION_DURATION:int = 500;
      
      private static const BUTTON_TWEEN_DELAY:int = 1200;
      
      private static const TEXTS_TWEEN_DELAY:int = 100;
      
      private static const TEXTS_TWEEN_TOP_PADDING:int = 15;
      
      private static const BUTTON_GAP:int = 30;
      
      private static const BUTTON_W:int = 160;
      
      private static const VEHICLE_TYPE_Y:int = 137;
      
      private static const SCALE_BIG:Number = 1;
      
      private static const SCALE_SMALL:Number = 0.75;
      
      private static const ANIMATION_FLAG:String = "animationFlag";
      
      private static const IN_HANGAR_EVENT_TYPE:String = "inHangar";
      
      private static const BACK_EVENT_TYPE:String = "back";
      
      private static const COLLECTIBLE_OFFSET:int = 33;
       
      
      public var titleTF:TextField;
      
      public var vehicleLevelTF:TextField;
      
      public var vehicleNameTF:TextField;
      
      public var image:UILoaderAlt;
      
      public var showInHangarButton:UniversalBtn;
      
      public var backButton:UniversalBtn;
      
      public var vehicleHighlight:MovieClip;
      
      public var collectibleTF:CollectibleStatus;
      
      private var _vehicleType:TankTypeIco;
      
      private var _isElite:Boolean;
      
      private var _isCollectible:Boolean;
      
      private var _showAnimation:Boolean;
      
      private var _tweens:Vector.<Tween>;
      
      private var _imageScale:Number = 1;
      
      public function VehicleCongratulationAnimation()
      {
         super();
         this._tweens = new Vector.<Tween>(0);
         this._vehicleType = App.utils.classFactory.getComponent(Linkages.TANK_TYPE_ICO_UI,TankTypeIco);
         this._vehicleType.x = 0;
         this._vehicleType.y = VEHICLE_TYPE_Y;
         addChild(this._vehicleType);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setSize(800,582);
         this.vehicleHighlight.visible = false;
         this.vehicleHighlight.stop();
         App.stageSizeMgr.register(this);
         this.image.addEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.disposeTweens();
         this.showInHangarButton.removeEventListener(ButtonEvent.CLICK,this.onShowInHangarButtonClickHandler);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this._tweens = null;
         this.titleTF = null;
         this.vehicleLevelTF = null;
         this.vehicleNameTF = null;
         this._vehicleType.dispose();
         this._vehicleType = null;
         this.image.removeEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         this.image.dispose();
         this.image = null;
         this.showInHangarButton.dispose();
         this.showInHangarButton = null;
         this.backButton.dispose();
         this.backButton = null;
         this.vehicleHighlight = null;
         this.collectibleTF.dispose();
         this.collectibleTF = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         visible = false;
         this._vehicleType.mouseEnabled = this._vehicleType.mouseChildren = false;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleTF.mouseWheelEnabled = this.titleTF.mouseEnabled = false;
         this.vehicleLevelTF.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleLevelTF.mouseWheelEnabled = this.vehicleLevelTF.mouseEnabled = false;
         this.vehicleNameTF.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleNameTF.mouseWheelEnabled = this.vehicleNameTF.mouseEnabled = false;
         this.image.maintainAspectRatio = false;
         this.image.mouseEnabled = this.image.mouseChildren = false;
         this.vehicleHighlight.mouseEnabled = this.vehicleHighlight.mouseChildren = false;
         App.utils.universalBtnStyles.setStyle(this.showInHangarButton,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         App.utils.universalBtnStyles.setStyle(this.backButton,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.showInHangarButton.minWidth = BUTTON_W;
         this.showInHangarButton.autoSize = TextFieldAutoSize.LEFT;
         this.showInHangarButton.addEventListener(ButtonEvent.CLICK,this.onShowInHangarButtonClickHandler);
         this.backButton.minWidth = BUTTON_W;
         this.backButton.autoSize = TextFieldAutoSize.LEFT;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 700
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public function setData(param1:Object) : void
      {
         this.image.autoSize = false;
         this._isElite = param1.isElite;
         this._isCollectible = param1.isCollectible;
         this._vehicleType.type = param1.vehicleType;
         this.titleTF.text = param1.title;
         this.vehicleLevelTF.text = param1.lvl;
         this.vehicleNameTF.text = param1.vName;
         this.image.sourceAlt = param1.imageAlt;
         this.image.source = param1.image;
         this.showInHangarButton.label = param1.btnLbl;
         this.backButton.label = param1.backBtnLbl;
         this.backButton.visible = param1.needBackBtn;
         invalidateSize();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 21
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      private function onStartVehicleHighlightAnimation(param1:Tween) : void
      {
         if(!_baseDisposed)
         {
            param1.onChange = null;
            this.vehicleHighlight.visible = true;
         }
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function onImageCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
         invalidate(ANIMATION_FLAG);
         this._showAnimation = true;
      }
      
      private function onShowInHangarButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(IN_HANGAR_EVENT_TYPE));
      }
      
      private function onBackButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(BACK_EVENT_TYPE));
      }
      
      private function repositionItems() : void
      {
         if(!this._isCollectible)
         {
            this.vehicleLevelTF.y -= COLLECTIBLE_OFFSET;
            this._vehicleType.y -= COLLECTIBLE_OFFSET;
            this.vehicleNameTF.y -= COLLECTIBLE_OFFSET;
         }
      }
   }
}
