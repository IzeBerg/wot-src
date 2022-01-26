package net.wg.gui.lobby.hangar
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class NYCreditBonus extends UIComponentEx
   {
       
      
      public var bonusIcon:Sprite = null;
      
      public var bonusText:MovieClip = null;
      
      public var bonusBg:MovieClip = null;
      
      public var hitMc:Sprite = null;
      
      private var _bonusAmount:String = "";
      
      private var _currentSize:String;
      
      private var _tfBonusText:TextField = null;
      
      private const LABEL_BG_BIG:String = "big";
      
      private const LABEL_BG_SMALL:String = "small";
      
      public function NYCreditBonus()
      {
         this._currentSize = this.LABEL_BG_BIG;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.gotoAndStop(this._currentSize);
         this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.onThisRollOutHandler);
         this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.onThisRollOverHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SIZE))
         {
            this.gotoAndStop(this._currentSize);
            this._tfBonusText = this.bonusText["bonusText"];
            this._tfBonusText.htmlText = this._bonusAmount;
            App.utils.commons.updateTextFieldSize(this._tfBonusText,true,true);
            this.updateLayout();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.onThisRollOutHandler);
         this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.onThisRollOverHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._tfBonusText = null;
         this.bonusText = null;
         this.bonusIcon = null;
         this.hitMc = null;
         super.onDispose();
      }
      
      public function updateSize(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? this.LABEL_BG_SMALL : this.LABEL_BG_BIG;
         if(this._currentSize != _loc2_)
         {
            this._currentSize = _loc2_;
            invalidateSize();
         }
      }
      
      private function updateLayout() : void
      {
         this.bonusIcon.x = this.bonusBg.width - this.bonusIcon.width - this.bonusText.width >> 1;
         this.bonusText.x = this.bonusIcon.x + this.bonusIcon.width;
         var _loc1_:Number = Math.max(this.bonusBg.height,this.bonusIcon.height,this.bonusText.height);
         this.bonusIcon.y = _loc1_ - this.bonusIcon.height >> 1;
         this.bonusText.y = _loc1_ - this.bonusText.height >> 1;
         this.bonusBg.y = _loc1_ - this.bonusBg.height >> 1;
      }
      
      public function set bonusAmount(param1:String) : void
      {
         if(param1 != Values.EMPTY_STR && this._bonusAmount != param1)
         {
            this._bonusAmount = param1;
            invalidateData();
         }
      }
      
      private function onThisRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onThisRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.NY_CREDIT_BONUS);
      }
   }
}
