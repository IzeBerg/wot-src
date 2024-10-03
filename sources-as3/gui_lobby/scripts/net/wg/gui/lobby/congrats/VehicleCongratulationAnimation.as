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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = LEFT_TF_OFFSET;
            _loc2_ = RIGHT_TF_OFFSET;
            if(this._isElite)
            {
               _loc1_ += TF_ELITE_EXTRA_OFFSET;
               _loc2_ += TF_ELITE_EXTRA_OFFSET;
            }
            _loc3_ = this.vehicleLevelTF.width + _loc1_ + this._vehicleType.width + _loc2_ + this.vehicleNameTF.width;
            _loc4_ = width - _loc3_ >> 1;
            this.titleTF.x = width - this.titleTF.width >> 1;
            this.collectibleTF.x = width - this.collectibleTF.width >> 1;
            this.vehicleLevelTF.x = _loc4_;
            _loc4_ += this.vehicleLevelTF.width + _loc1_;
            this._vehicleType.x = _loc4_;
            _loc4_ += _loc2_ + this._vehicleType.width;
            this.vehicleNameTF.x = _loc4_;
            if(this.backButton.visible)
            {
               this.showInHangarButton.x = width - this.showInHangarButton.width - this.backButton.width - BUTTON_GAP >> 1;
               this.backButton.x = this.showInHangarButton.x + this.showInHangarButton.width + BUTTON_GAP | 0;
            }
            else
            {
               this.showInHangarButton.x = width - this.showInHangarButton.width >> 1;
            }
            this.image.scaleX = this.image.scaleY = this._imageScale;
            this.image.x = (width - this.image.width >> 1) - VEHICLE_H_OFFSET * this._imageScale;
            this.image.y = (height - this.image.height >> 1) + VEHICLE_V_OFFSET / this._imageScale;
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._showAnimation && isInvalid(ANIMATION_FLAG))
         {
            this._showAnimation = false;
            visible = true;
            this.disposeTweens();
            this.repositionItems();
            this._tweens.push(new Tween(ANIMATION_DURATION,this.titleTF,{
               "y":this.titleTF.y,
               "alpha":1
            },{
               "ease":Regular.easeOut,
               "fastTransform":false
            }));
            this.titleTF.y -= TEXTS_TWEEN_TOP_PADDING;
            this.titleTF.alpha = 0;
            if(this._isCollectible)
            {
               this._tweens.push(new Tween(ANIMATION_DURATION,this.collectibleTF,{
                  "y":this.collectibleTF.y,
                  "alpha":1
               },{
                  "ease":Regular.easeOut,
                  "fastTransform":false
               }));
            }
            this.collectibleTF.y -= TEXTS_TWEEN_TOP_PADDING;
            this.collectibleTF.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION,this.vehicleLevelTF,{
               "y":this.vehicleLevelTF.y,
               "alpha":1
            },{
               "ease":Regular.easeOut,
               "fastTransform":false,
               "delay":TEXTS_TWEEN_DELAY
            }));
            this.vehicleLevelTF.y -= TEXTS_TWEEN_TOP_PADDING;
            this.vehicleLevelTF.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION,this._vehicleType,{
               "y":this._vehicleType.y,
               "alpha":1
            },{
               "ease":Regular.easeOut,
               "fastTransform":false,
               "delay":TEXTS_TWEEN_DELAY
            }));
            this._vehicleType.y -= TEXTS_TWEEN_TOP_PADDING;
            this._vehicleType.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION,this.vehicleNameTF,{
               "y":this.vehicleNameTF.y,
               "alpha":1
            },{
               "ease":Regular.easeOut,
               "fastTransform":false,
               "delay":TEXTS_TWEEN_DELAY
            }));
            this.vehicleNameTF.y -= TEXTS_TWEEN_TOP_PADDING;
            this.vehicleNameTF.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION * 1.2,this.image,{
               "x":this.image.x,
               "y":this.image.y,
               "alpha":1,
               "scaleX":this._imageScale,
               "scaleY":this._imageScale
            },{
               "ease":Back.easeOut,
               "fastTransform":false,
               "delay":200
            }));
            this.image.scaleX = 0.5 * this._imageScale;
            this.image.scaleY = 0.5 * this._imageScale;
            this.image.x = (width - this.image.width >> 1) + 30 * this._imageScale;
            this.image.y = height - this.image.height >> 1;
            this.image.alpha = 0;
            this.vehicleHighlight.scaleX = this.vehicleHighlight.scaleY = this._imageScale;
            this.vehicleHighlight.x = width - this.vehicleHighlight.width >> 1;
            this.vehicleHighlight.y = (height - this.vehicleHighlight.height >> 1) + VEHICLE_HIGHLIGHT_OFFSET / this._imageScale + 30;
            this.vehicleHighlight.alpha = 1;
            this.vehicleHighlight.visible = false;
            this._tweens.push(new Tween(ANIMATION_DURATION * 3,this.vehicleHighlight,{
               "scaleX":4 * this._imageScale,
               "scaleY":3 * this._imageScale,
               "alpha":0,
               "x":width - this.vehicleHighlight.width * 4 >> 1,
               "y":(height - this.vehicleHighlight.height * 3 >> 1) + VEHICLE_HIGHLIGHT_OFFSET * this._imageScale
            },{
               "ease":Strong.easeOut,
               "fastTransform":false,
               "delay":ANIMATION_DURATION * 0.75,
               "onChange":this.onStartVehicleHighlightAnimation
            }));
            this._tweens.push(new Tween(ANIMATION_DURATION,this.showInHangarButton,{"alpha":1},{
               "ease":Strong.easeOut,
               "fastTransform":false,
               "delay":BUTTON_TWEEN_DELAY
            }));
            this.showInHangarButton.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION,this.backButton,{"alpha":1},{
               "ease":Strong.easeOut,
               "fastTransform":false,
               "delay":BUTTON_TWEEN_DELAY
            }));
            this.backButton.alpha = 0;
         }
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
         this._imageScale = param2 >= StageSizeBoundaries.HEIGHT_900 ? Number(SCALE_BIG) : Number(SCALE_SMALL);
         invalidateSize();
      }
      
      private function onStartVehicleHighlightAnimation(param1:Tween) : void
      {
         if(!_baseDisposed)
         {
            param1.onChange = null;
            if(this.vehicleHighlight)
            {
               this.vehicleHighlight.visible = true;
            }
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
      
      private function repositionItems() : void
      {
         if(!this._isCollectible)
         {
            this.vehicleLevelTF.y -= COLLECTIBLE_OFFSET;
            this._vehicleType.y -= COLLECTIBLE_OFFSET;
            this.vehicleNameTF.y -= COLLECTIBLE_OFFSET;
         }
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
   }
}
