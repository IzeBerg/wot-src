package net.wg.gui.lobby.dialogs
{
   import flash.display.DisplayObjectContainer;
   import net.wg.gui.lobby.dialogs.data.IconPriceDialogVO;
   import net.wg.infrastructure.base.meta.IIconPriceDialogMeta;
   import net.wg.infrastructure.base.meta.impl.IconPriceDialogMeta;
   
   public class IconPriceDialog extends IconPriceDialogMeta implements IIconPriceDialogMeta
   {
      
      private static const PRICE_BOTTOM_OFFSET:int = 14;
      
      protected static const PRICE_TEXT_OFFSET:int = 13;
       
      
      public var priceMc:PriceMc;
      
      public function IconPriceDialog()
      {
         super();
      }
      
      override protected function applyLayout() : void
      {
         super.applyLayout();
         this.priceMc.y = getBackgroundActualHeight() - this.priceMc.height - PRICE_BOTTOM_OFFSET;
      }
      
      override protected function getTextAreaCurrentHeight() : Number
      {
         var _loc1_:Number = super.getTextAreaCurrentHeight();
         return _loc1_ + PRICE_TEXT_OFFSET + this.priceMc.height + PRICE_BOTTOM_OFFSET;
      }
      
      override protected function setMessagePrice(param1:IconPriceDialogVO) : void
      {
         this.priceMc.setPriceData(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         if(this.priceMc)
         {
            this.priceMc.dispose();
            _loc1_ = this.priceMc.parent;
            if(_loc1_)
            {
               _loc1_.removeChild(this.priceMc);
            }
            this.priceMc = null;
         }
         super.onDispose();
      }
      
      public function as_setOperationAllowed(param1:Boolean) : void
      {
         this.priceMc.allowed = param1;
      }
      
      public function as_setPriceLabel(param1:String) : void
      {
         this.priceMc.textField.text = param1;
      }
   }
}
