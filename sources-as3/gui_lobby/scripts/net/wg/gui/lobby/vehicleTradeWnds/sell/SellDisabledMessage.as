package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SellDisabledMessage extends UIComponentEx
   {
       
      
      public var titleTf:TextField = null;
      
      public var labelTf:TextField = null;
      
      public function SellDisabledMessage()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.titleTf.y = height - this.titleTf.height - this.labelTf.height >> 1;
            this.labelTf.y = this.titleTf.y + this.titleTf.height;
         }
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         this.labelTf = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTf.text = TOOLTIPS.VEHICLESELLDIALOG_ACCEPTBUTTONTOOLTIP_NOTENABLE_HEADER;
      }
      
      public function setMessage(param1:String) : void
      {
         this.labelTf.text = param1;
         App.utils.commons.updateTextFieldSize(this.labelTf,false,true);
         invalidateData();
      }
   }
}
