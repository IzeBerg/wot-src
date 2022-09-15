package net.wg.gui.lobby.storage.categories.blueprints
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class BlueprintsNoItemsView extends UIComponentEx
   {
       
      
      public var titleReceiveTF:TextField = null;
      
      public var descrReceiveTF:TextField = null;
      
      public var titleFillTF:TextField = null;
      
      public var descrFillTF:TextField = null;
      
      public var titleDiscountTF:TextField = null;
      
      public var descrDiscountTF:TextField = null;
      
      public function BlueprintsNoItemsView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleReceiveTF.multiline = true;
         this.titleReceiveTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleReceiveTF.text = STORAGE.BLUEPRINTS_NOITEMS_RECEIVE_HEADER;
         this.descrReceiveTF.multiline = true;
         this.descrReceiveTF.autoSize = TextFieldAutoSize.LEFT;
         this.descrReceiveTF.text = STORAGE.BLUEPRINTS_NOITEMS_RECEIVE_BODY;
         this.titleFillTF.multiline = true;
         this.titleFillTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleFillTF.text = STORAGE.BLUEPRINTS_NOITEMS_FILL_HEADER;
         this.descrFillTF.multiline = true;
         this.descrFillTF.autoSize = TextFieldAutoSize.LEFT;
         this.descrFillTF.text = STORAGE.BLUEPRINTS_NOITEMS_FILL_BODY;
         this.titleDiscountTF.multiline = true;
         this.titleDiscountTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleDiscountTF.text = STORAGE.BLUEPRINTS_NOITEMS_DISCOUNT_HEADER;
         this.descrDiscountTF.multiline = true;
         this.descrDiscountTF.autoSize = TextFieldAutoSize.LEFT;
         this.descrDiscountTF.text = STORAGE.BLUEPRINTS_NOITEMS_DISCOUNT_BODY;
      }
      
      override protected function onDispose() : void
      {
         this.titleReceiveTF = null;
         this.descrReceiveTF = null;
         this.titleFillTF = null;
         this.descrFillTF = null;
         this.titleDiscountTF = null;
         this.descrDiscountTF = null;
         super.onDispose();
      }
   }
}
