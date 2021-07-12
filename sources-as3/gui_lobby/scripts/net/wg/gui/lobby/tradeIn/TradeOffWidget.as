package net.wg.gui.lobby.tradeIn
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.tradeIn.vo.TradeOffWidgetVO;
   import net.wg.infrastructure.base.meta.impl.TradeOffWidgetMeta;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class TradeOffWidget extends TradeOffWidgetMeta
   {
      
      private static const ENABLED_ALPHA:Number = 1;
      
      private static const DISABLED_ALPHA:Number = 0.67;
       
      
      public var buttonHitArea:Sprite;
      
      public var resetButtonHitArea:Sprite;
      
      public var tradeIcon:Sprite;
      
      public var tradeTitleTF:TextField;
      
      public var vehicleFlag:IImage;
      
      public var vehicleImage:IImage;
      
      public var vehicleType:IImage;
      
      public var vehicleLevel:IImage;
      
      public var vehicleTitleTF:TextField;
      
      public var buttonHover:Sprite;
      
      public var backgroundShadow:Sprite;
      
      public var resetButtonHover:Sprite;
      
      public var resetBackgroundShadow:Sprite;
      
      public var resetButtonPersonal:Sprite;
      
      public var resetButton:Sprite;
      
      private var _isPersonal:Boolean;
      
      private var _data:TradeOffWidgetVO;
      
      public function TradeOffWidget()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.tradeIcon = null;
         this.tradeTitleTF = null;
         this.vehicleFlag.dispose();
         this.vehicleFlag = null;
         this.vehicleImage.dispose();
         this.vehicleImage = null;
         this.vehicleType.dispose();
         this.vehicleType = null;
         this.vehicleLevel.dispose();
         this.vehicleLevel = null;
         this.vehicleTitleTF = null;
         this.buttonHover = null;
         this.backgroundShadow = null;
         this.resetButtonHover = null;
         this.resetBackgroundShadow = null;
         this.resetButton = null;
         this.resetButtonPersonal = null;
         this.buttonHitArea.removeEventListener(MouseEvent.CLICK,this.onButtonHitAreaClickHandler);
         this.buttonHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.onButtonHitAreaDownHandler);
         this.buttonHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.buttonHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.buttonHitArea = null;
         this.resetButtonHitArea.removeEventListener(MouseEvent.CLICK,this.onResetButtonHitAreaClickHandler);
         this.resetButtonHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.onButtonHitAreaDownHandler);
         this.resetButtonHitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onResetButtonRollOverHandler);
         this.resetButtonHitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onResetButtonRollOutHandler);
         this.resetButtonHitArea = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.backgroundShadow.mouseEnabled = this.backgroundShadow.mouseChildren = false;
         this.resetButtonPersonal.visible = false;
         this.resetBackgroundShadow.mouseEnabled = this.resetBackgroundShadow.mouseChildren = false;
         this.buttonHover.mouseEnabled = this.buttonHover.mouseChildren = this.buttonHover.visible = false;
         this.resetButtonHover.mouseEnabled = this.resetButtonHover.mouseChildren = this.resetButtonHover.visible = false;
         this.resetButton.mouseEnabled = this.resetButton.mouseChildren = false;
         this.resetButtonPersonal.mouseEnabled = this.resetButtonPersonal.mouseChildren = false;
         this.buttonHitArea.addEventListener(MouseEvent.CLICK,this.onButtonHitAreaClickHandler);
         this.buttonHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonHitAreaDownHandler);
         this.buttonHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.buttonHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.buttonHitArea.buttonMode = true;
         this.resetButtonHitArea.addEventListener(MouseEvent.CLICK,this.onResetButtonHitAreaClickHandler);
         this.resetButtonHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonHitAreaDownHandler);
         this.resetButtonHitArea.addEventListener(MouseEvent.ROLL_OVER,this.onResetButtonRollOverHandler);
         this.resetButtonHitArea.addEventListener(MouseEvent.ROLL_OUT,this.onResetButtonRollOutHandler);
         this.resetButtonHitArea.buttonMode = true;
         this.tradeIcon.mouseEnabled = this.tradeIcon.mouseChildren = false;
         this.tradeTitleTF.autoSize = TextFieldAutoSize.LEFT;
         this.tradeTitleTF.text = DIALOGS.TRADEOFFWIDGET_SELECTVEHICLE;
         this.tradeTitleTF.mouseEnabled = false;
         this.vehicleFlag.mouseEnabled = this.vehicleFlag.mouseChildren = false;
         this.vehicleImage.mouseEnabled = this.vehicleImage.mouseChildren = false;
         this.vehicleType.mouseEnabled = this.vehicleType.mouseChildren = false;
         this.vehicleLevel.mouseEnabled = this.vehicleLevel.mouseChildren = false;
         this.vehicleTitleTF.autoSize = TextFieldAutoSize.LEFT;
         this.vehicleTitleTF.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this._isPersonal = this._data.isPersonal;
            enabled = this._data.available;
            alpha = !!enabled ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
            _loc1_ = this._data.showTradeOff;
            _loc2_ = !_loc1_;
            if(_loc2_)
            {
               this.vehicleFlag.source = this._data.vehicleNationFlag;
               this.vehicleImage.source = this._data.vehicleIcon;
               this.vehicleType.source = this._data.vehicleType;
               this.vehicleLevel.source = this._data.vehicleLevel;
               this.vehicleTitleTF.text = this._data.vehicleTitle;
            }
            this.tradeIcon.visible = _loc1_;
            this.tradeTitleTF.visible = _loc1_;
            this.vehicleFlag.visible = _loc2_;
            this.vehicleImage.visible = _loc2_;
            this.vehicleType.visible = _loc2_;
            this.vehicleLevel.visible = _loc2_;
            this.vehicleTitleTF.visible = _loc2_;
            this.resetBackgroundShadow.visible = _loc2_ || this._isPersonal;
            this.resetButton.visible = _loc2_ && !this._isPersonal;
            this.resetButtonPersonal.visible = this._isPersonal;
            this.resetButtonHitArea.visible = _loc2_ || this._isPersonal;
            this.buttonHitArea.buttonMode = this._data.available;
         }
      }
      
      override protected function setData(param1:TradeOffWidgetVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function showTooltip() : void
      {
         var _loc1_:Object = getTooltipS();
         App.toolTipMgr.showSpecial(_loc1_.type,null,_loc1_.data);
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.CUSTOMIZATION_DEFAULT,null);
      }
      
      override public function get width() : Number
      {
         return this.resetBackgroundShadow.x + this.resetBackgroundShadow.width - this.backgroundShadow.x >> 0;
      }
      
      override public function get height() : Number
      {
         return this.backgroundShadow.height;
      }
      
      private function onButtonHitAreaClickHandler(param1:MouseEvent) : void
      {
         if(enabled)
         {
            if(App.utils.commons.isLeftButton(param1))
            {
               onClickS();
            }
         }
      }
      
      private function onButtonHitAreaDownHandler(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.NORMAL_BTN,null);
      }
      
      private function onButtonRollOverHandler(param1:MouseEvent) : void
      {
         this.buttonHover.visible = enabled;
         this.showTooltip();
      }
      
      private function onButtonRollOutHandler(param1:MouseEvent) : void
      {
         this.buttonHover.visible = false;
         App.toolTipMgr.hide();
      }
      
      private function onResetButtonHitAreaClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            onResetClickS();
         }
      }
      
      private function onResetButtonRollOverHandler(param1:MouseEvent) : void
      {
         this.resetButtonHover.visible = enabled;
         if(this._isPersonal)
         {
            this.showTooltip();
         }
      }
      
      private function onResetButtonRollOutHandler(param1:MouseEvent) : void
      {
         this.resetButtonHover.visible = false;
         if(this._isPersonal)
         {
            App.toolTipMgr.hide();
         }
      }
   }
}
