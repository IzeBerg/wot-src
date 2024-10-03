package net.wg.white_tiger.gui.lobby.battleQueue.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelHunterInfoVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.events.QuickStartEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class QuickStartVehicleRenderer extends UIComponentEx implements ISoundable
   {
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_HOVER:String = "hover";
      
      public static const STATE_SELECTED:String = "selected";
      
      public static const FRAMELABEL_POSRFIX_SMALL:String = "_small";
      
      private static const WIDTH_BIG:int = 216;
      
      private static const HEIGHT_BIG:int = 110;
      
      private static const WIDTH_SMALL:int = 180;
      
      private static const HEIGHT_SMALL:int = 100;
      
      private static const VEHICLE_NAME_OFFSET_X:int = 13;
      
      private static const VEHICLE_NAME_OFFSET_Y:int = 6;
      
      private static const VEHICLE_TYPE_OFFSET_X:int = 0;
      
      private static const BG_ALPHA_NORMAL:Number = 0.4;
      
      private static const BG_ALPHA_HOVER:Number = 0.7;
      
      private static const BG_ALPHA_SELECTED:Number = 0.7;
      
      private static const HOVER_FX_ALPHA:Number = 0.75;
      
      private static const FADE_DURATION:int = 300;
      
      private static const BORDER_ALPHA_NORMAL:Number = 0.9;
      
      private static const BORDER_ALPHA_HOVER:Number = 0.35;
      
      private static const BORDER_ALPHA_SELECTED:Number = 0.9;
       
      
      public var effect:Sprite = null;
      
      public var bg:Sprite = null;
      
      public var disabledBg:Sprite = null;
      
      public var border:MovieClip = null;
      
      public var vehicleIcon:Image = null;
      
      public var vehicleType:Image = null;
      
      public var vehicleName:TextField = null;
      
      public var statusImage:IImage = null;
      
      public var statusText:TextField = null;
      
      private var _data:QuickStartPanelHunterInfoVO = null;
      
      private var _isSmall:Boolean = false;
      
      private var _state:String = "normal";
      
      private var _tween:Tween = null;
      
      private var _soundMgr:ISoundManager;
      
      public function QuickStartVehicleRenderer()
      {
         this._soundMgr = App.soundMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.clearTween();
         this.vehicleIcon.removeEventListener(Event.CHANGE,this.onVehicleIconChangeHandler);
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this.vehicleType.removeEventListener(Event.CHANGE,this.onVehicleTypeChangeHandler);
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.effect = null;
         this.bg = null;
         this.border = null;
         this.vehicleName = null;
         this.disabledBg = null;
         this.statusText = null;
         this.statusImage.removeEventListener(Event.CHANGE,this.onStatusImageChangeHandler);
         this.statusImage.dispose();
         this.statusImage = null;
         this._data = null;
         this._soundMgr.removeSoundHdlrs(this);
         this._soundMgr = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setSize(WIDTH_BIG,HEIGHT_BIG);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehicleIcon.addEventListener(Event.CHANGE,this.onVehicleIconChangeHandler);
         this.vehicleType.addEventListener(Event.CHANGE,this.onVehicleTypeChangeHandler);
         this.statusImage.addEventListener(Event.CHANGE,this.onStatusImageChangeHandler);
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         mouseChildren = false;
         buttonMode = true;
         this.disabledBg.visible = this.statusImage.visible = this.statusText.visible = false;
         this._soundMgr.addSoundsHdlrs(this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.vehicleIcon.source = this._data.icon;
               this.vehicleType.source = this._data.typeIcon;
               this.vehicleName.text = this._data.name;
               App.utils.commons.updateTextFieldSize(this.vehicleName);
               this.disabledBg.visible = this.statusImage.visible = this.statusText.visible = this._data.isInBattle;
               if(this._data.isInBattle && !this.statusImage.source)
               {
                  this.statusImage.source = RES_ICONS_WHITE_TIGER.WHITE_TIGER_GUI_MAPS_ICONS_CAROUSEL_INBATTLE;
                  this.statusText.text = EVENT.WTEVENTSCAROUSELVIEW_INBATTLETEXT;
                  App.utils.commons.updateTextFieldSize(this.statusText);
               }
            }
            _loc1_ = isInvalid(InvalidationType.SIZE);
            if(_loc1_)
            {
               this.vehicleIcon.x = _width - this.vehicleIcon.width >> 1;
               this.vehicleIcon.y = _height - this.vehicleIcon.height >> 1;
               this.bg.width = this.effect.width = width;
               this.bg.height = this.effect.height = height;
               this.vehicleName.x = width - this.vehicleName.textWidth - VEHICLE_NAME_OFFSET_X;
               this.vehicleName.y = height - this.vehicleName.textHeight - VEHICLE_NAME_OFFSET_Y;
               this.vehicleType.x = this.vehicleName.x - this.vehicleType.width - VEHICLE_TYPE_OFFSET_X;
               this.vehicleType.y = this.vehicleName.y;
               if(this._data.isInBattle)
               {
                  this.disabledBg.width = width;
                  this.disabledBg.height = height;
                  _loc3_ = -10;
                  _loc4_ = 0;
                  _loc5_ = this.statusImage.width + _loc4_ + this.statusText.textWidth;
                  this.statusImage.x = (width - _loc5_ >> 1) + _loc3_;
                  this.statusText.x = this.statusImage.x + this.statusImage.width + _loc4_;
                  this.statusImage.y = height - this.statusImage.height >> 1;
                  this.statusText.y = height - this.statusText.height >> 1;
               }
            }
            _loc2_ = isInvalid(InvalidationType.STATE);
            if(_loc2_)
            {
               switch(this._state)
               {
                  case STATE_SELECTED:
                     this.bg.alpha = BG_ALPHA_SELECTED;
                     this.border.alpha = BORDER_ALPHA_SELECTED;
                     this.showEffect(false);
                     break;
                  case STATE_HOVER:
                     this.bg.alpha = BG_ALPHA_HOVER;
                     this.border.alpha = BORDER_ALPHA_HOVER;
                     this.showEffect(true);
                     break;
                  case STATE_NORMAL:
                  default:
                     this.bg.alpha = BG_ALPHA_NORMAL;
                     this.border.alpha = BORDER_ALPHA_NORMAL;
                     this.showEffect(false);
               }
            }
            if(_loc2_ || _loc1_)
            {
               _loc6_ = this._state + (!!this._isSmall ? FRAMELABEL_POSRFIX_SMALL : Values.EMPTY_STR);
               this.border.gotoAndStop(_loc6_);
            }
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.CAROUSEL_BTN;
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function showEffect(param1:Boolean) : void
      {
         this.clearTween();
         this._tween = new Tween(FADE_DURATION,this.effect,{"alpha":(!!param1 ? HOVER_FX_ALPHA : 0)});
      }
      
      public function get data() : QuickStartPanelHunterInfoVO
      {
         return this._data;
      }
      
      public function set data(param1:QuickStartPanelHunterInfoVO) : void
      {
         this._data = param1;
         invalidateData();
         this.state = STATE_NORMAL;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != this._isSmall)
         {
            this._isSmall = param1;
            _loc2_ = !!param1 ? int(WIDTH_SMALL) : int(WIDTH_BIG);
            _loc3_ = !!param1 ? int(HEIGHT_SMALL) : int(HEIGHT_BIG);
            setSize(_loc2_,_loc3_);
         }
      }
      
      public function set state(param1:String) : void
      {
         if(param1 != this._state)
         {
            this._state = param1;
            invalidateState();
         }
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(this._state == STATE_SELECTED)
         {
            return;
         }
         this.state = STATE_SELECTED;
         dispatchEvent(new QuickStartEvent(QuickStartEvent.VEHICLE_SELECTED,this._data.vehID));
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._state == STATE_SELECTED)
         {
            return;
         }
         this.state = STATE_HOVER;
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(this._state == STATE_SELECTED)
         {
            return;
         }
         this.state = STATE_NORMAL;
      }
      
      private function onVehicleIconChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onVehicleTypeChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onStatusImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
