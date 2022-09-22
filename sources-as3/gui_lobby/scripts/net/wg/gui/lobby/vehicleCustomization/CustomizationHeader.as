package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.tooltips.helpers.TankTypeIco;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationStyleInfoEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationHeader extends UIComponentEx
   {
      
      private static const OFFSET:int = 11;
      
      private static const LEFT_TF_OFFSET:int = 16;
      
      private static const RIGHT_TF_OFFSET:int = -12;
      
      private static const TF_ELITE_EXTRA_OFFSET:int = 10;
       
      
      public var tankTier:TextField = null;
      
      public var tankName:TextField = null;
      
      public var tankIcon:TankTypeIco = null;
      
      public var tankInfo:TextField = null;
      
      public var closeBtn:CloseButtonText = null;
      
      public var progressionInfoBtn:ISoundButtonEx = null;
      
      private var _data:CustomizationHeaderVO = null;
      
      private var _actualWidth:int = -1;
      
      public function CustomizationHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stage.addEventListener(CustomizationStyleInfoEvent.SHOW_STYLE_INFO,this.onShowStyleInfoHandler);
         App.stage.addEventListener(CustomizationStyleInfoEvent.HIDE_STYLE_INFO,this.onCloseStyleInfoHandler);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_CLOSE;
         this.progressionInfoBtn.addEventListener(ButtonEvent.CLICK,this.onProgressionInfoBtnClickHandler);
         this.progressionInfoBtn.label = VEHICLE_CUSTOMIZATION.CUSTOMIZATIONHEADER_ABOUTPROGRESSIVESTYLES;
         this.progressionInfoBtn.visible = false;
         mouseEnabled = false;
         this.tankName.mouseEnabled = this.tankTier.mouseEnabled = this.tankInfo.mouseEnabled = false;
         this.tankIcon.mouseEnabled = this.tankIcon.mouseChildren = false;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawCircle(0,0,0.1);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         hitArea = _loc1_;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.tankIcon.type = this._data.tankType;
               this.tankTier.text = this._data.tankTier;
               this.tankName.text = this._data.tankName;
               this.tankInfo.htmlText = this._data.tankInfo;
               App.utils.commons.updateTextFieldSize(this.tankTier,true,false);
               App.utils.commons.updateTextFieldSize(this.tankName,true,false);
               App.utils.commons.updateTextFieldSize(this.tankInfo,true,false);
               this.closeBtn.tooltip = this._data.closeBtnTooltip;
               this.progressionInfoBtn.visible = this._data.isQuestProgressionInfoBtnVisible;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc1_ = LEFT_TF_OFFSET;
               _loc2_ = RIGHT_TF_OFFSET;
               if(this._data.isElite)
               {
                  _loc1_ += TF_ELITE_EXTRA_OFFSET;
                  _loc2_ += TF_ELITE_EXTRA_OFFSET;
               }
               _loc3_ = this.tankTier.width + _loc1_ + this.tankIcon.width + _loc2_ + this.tankName.width;
               _loc4_ = this._actualWidth - _loc3_ >> 1;
               this.tankTier.x = _loc4_;
               _loc4_ += this.tankTier.width + _loc1_;
               this.tankIcon.x = _loc4_;
               _loc4_ += _loc2_ + this.tankIcon.width;
               this.tankName.x = _loc4_;
               this.closeBtn.validateNow();
               this.closeBtn.x = this._actualWidth - this.closeBtn.width - OFFSET;
               this.tankInfo.x = this._actualWidth - this.tankInfo.width >> 1;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.stage.removeEventListener(CustomizationStyleInfoEvent.SHOW_STYLE_INFO,this.onShowStyleInfoHandler);
         App.stage.removeEventListener(CustomizationStyleInfoEvent.HIDE_STYLE_INFO,this.onCloseStyleInfoHandler);
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.progressionInfoBtn.removeEventListener(ButtonEvent.CLICK,this.onProgressionInfoBtnClickHandler);
         this.tankTier = null;
         this.tankName = null;
         this.tankInfo = null;
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.progressionInfoBtn.dispose();
         this.progressionInfoBtn = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setHeaderData(param1:CustomizationHeaderVO) : void
      {
         this._data = param1;
         invalidateData();
         invalidateSize();
      }
      
      public function updateSize(param1:Number) : void
      {
         this._actualWidth = param1;
         invalidateSize();
      }
      
      private function onProgressionInfoBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_PROGRESSION_INFO,true));
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationEvent(CustomizationEvent.CLOSE_VIEW,true));
      }
      
      private function onShowStyleInfoHandler(param1:CustomizationStyleInfoEvent) : void
      {
         this.closeBtn.visible = false;
         this.tankInfo.visible = false;
      }
      
      private function onCloseStyleInfoHandler(param1:CustomizationStyleInfoEvent) : void
      {
         this.closeBtn.visible = true;
         this.tankInfo.visible = true;
      }
   }
}
