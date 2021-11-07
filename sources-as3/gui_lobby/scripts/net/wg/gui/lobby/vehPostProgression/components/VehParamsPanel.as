package net.wg.gui.lobby.vehPostProgression.components
{
   import fl.motion.easing.Circular;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.hangar.VehicleParameters;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class VehParamsPanel extends UIComponentEx
   {
      
      private static const BTN_TTC_RIGHT_MARGIN:int = 30;
      
      private static const BTN_TTC_BOTTOM_MARGIN:int = 10;
      
      private static const PARAMS_TOP_MARGIN:int = -10;
      
      private static const PARAMS_BOTTOM_MARGIN:int = 52;
      
      private static const TWEEN_SHOW_TIME:int = 200;
      
      private static const TWEEN_HIDE_TIME:int = 200;
       
      
      public var buttonTTC:SoundButtonEx = null;
      
      public var panel:VehParamsInnerBlock = null;
      
      private var _allowHide:Boolean = false;
      
      private var _isPanelShown:Boolean = false;
      
      private var _paramsY:int = -1;
      
      private var _paramsHeight:int = -1;
      
      private var _tweenShow:Tween;
      
      private var _tweenHide:Tween;
      
      public function VehParamsPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buttonTTC.addEventListener(MouseEvent.CLICK,this.onButtonTTCClickHandler);
         this._tweenShow = new Tween(TWEEN_SHOW_TIME,this,{"xPos":0},{
            "paused":true,
            "ease":Circular.easeOut
         });
         this._tweenHide = new Tween(TWEEN_HIDE_TIME,this,{"xPos":this.width},{
            "paused":true,
            "ease":Circular.easeOut
         });
      }
      
      override protected function onDispose() : void
      {
         this.panel.dispose();
         this.panel = null;
         this.buttonTTC.removeEventListener(MouseEvent.CLICK,this.onButtonTTCClickHandler);
         this.buttonTTC.dispose();
         this.buttonTTC = null;
         this._tweenShow.dispose();
         this._tweenShow = null;
         this._tweenHide.dispose();
         this._tweenHide = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.buttonTTC.visible = this._allowHide;
            this.panel.bg.visible = this._allowHide;
            this.buttonTTC.label = !!this._isPanelShown ? VEH_POST_PROGRESSION.VEHPOSTPROGRESSIONVIEW_HIDEVEHPARAMS : VEH_POST_PROGRESSION.VEHPOSTPROGRESSIONVIEW_SHOWVEHPARAMS;
            this.buttonTTC.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.buttonTTC.x = this.width - this.buttonTTC.hitMc.width - BTN_TTC_RIGHT_MARGIN;
            this.buttonTTC.y = this._paramsY - this.buttonTTC.height - BTN_TTC_BOTTOM_MARGIN;
            this.panel.height = _height;
            this.params.y = this._paramsY;
            this.params.height = this._paramsHeight;
         }
      }
      
      public function hide() : void
      {
         this.playHideTween();
         this._isPanelShown = false;
      }
      
      public function setDemountAllButtonLabel(param1:String) : void
      {
         this.panel.setDemountAllButtonLabel(param1);
      }
      
      public function setParamsDimensions(param1:Number, param2:Number) : void
      {
         this._paramsY = param1 + PARAMS_TOP_MARGIN;
         this._paramsHeight = param2 - PARAMS_BOTTOM_MARGIN;
         invalidateSize();
      }
      
      private function playShowTween() : void
      {
         this._tweenHide.reset();
         this._tweenHide.paused = true;
         this._tweenShow.reset();
         this._tweenShow.paused = false;
      }
      
      private function playHideTween() : void
      {
         this._tweenShow.reset();
         this._tweenShow.paused = true;
         this._tweenHide.reset();
         this._tweenHide.paused = false;
      }
      
      override public function get width() : Number
      {
         return this.panel.bg.width;
      }
      
      public function set showDemountAllPairsBtn(param1:Boolean) : void
      {
         this.panel.showDemountAllPairsBtn = param1;
      }
      
      public function get xPos() : Number
      {
         return this.panel.x;
      }
      
      public function set xPos(param1:Number) : void
      {
         this.panel.x = param1;
      }
      
      public function get allowHide() : Boolean
      {
         return this._allowHide;
      }
      
      public function set allowHide(param1:Boolean) : void
      {
         if(this._allowHide != param1)
         {
            this._allowHide = param1;
            if(!param1)
            {
               this._isPanelShown = false;
            }
            this.panel.x = !!param1 ? Number(this.width) : Number(0);
            invalidateData();
         }
      }
      
      public function get params() : VehicleParameters
      {
         return this.panel.params;
      }
      
      public function get isPanelShown() : Boolean
      {
         return this._isPanelShown;
      }
      
      private function onButtonTTCClickHandler(param1:MouseEvent) : void
      {
         if(this._isPanelShown)
         {
            this.playHideTween();
         }
         else
         {
            this.playShowTween();
         }
         this._isPanelShown = !this._isPanelShown;
         invalidateData();
      }
   }
}
