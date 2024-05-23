package net.wg.gui.lobby.techtree.controls
{
   import flash.text.TextField;
   import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EAField extends UIComponentEx
   {
      
      private static const LABEL_ALPHA:Number = 0.7;
       
      
      public var eaLabel:TextField;
      
      public var eaIcon:XPIcon;
      
      private var _eaShowMinValue:Boolean = false;
      
      private var _eaMinValue:Number = 0;
      
      private var _eaMaxValue:Number = 0;
      
      public function EAField()
      {
         super();
         this.eaLabel.alpha = LABEL_ALPHA;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._eaShowMinValue)
            {
               this.eaLabel.text = App.utils.locale.integer(this._eaMinValue) + " / " + App.utils.locale.integer(this._eaMaxValue);
            }
            else
            {
               this.eaLabel.text = App.utils.locale.integer(this._eaMaxValue);
            }
            this.eaIcon.type = XpTypeStrings.EA_COIN_TYPE;
         }
      }
      
      override protected function onDispose() : void
      {
         this.eaLabel = null;
         this.eaIcon.dispose();
         this.eaIcon = null;
         super.onDispose();
      }
      
      public function setData(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._eaShowMinValue = param3;
         this._eaMinValue = param1;
         this._eaMaxValue = param2;
         invalidateData();
      }
   }
}
