package net.wg.gui.lobby.techtree.controls
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class XPField extends UIComponentEx
   {
       
      
      public var xpLabel:TextField;
      
      public var xpIcon:XPIcon;
      
      private var _xpValue:Number = 0;
      
      private var _xpType:String = "earned";
      
      public function XPField()
      {
         super();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.xpLabel.text = App.utils.locale.integer(this._xpValue);
            this.xpIcon.type = this._xpType;
         }
      }
      
      override protected function onDispose() : void
      {
         this.xpLabel = null;
         this.xpIcon.dispose();
         this.xpIcon = null;
         super.onDispose();
      }
      
      public function setData(param1:Number, param2:String) : void
      {
         this._xpValue = param1;
         this._xpType = param2;
         invalidateData();
      }
   }
}
