package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   
   public class HBC_ActionItem extends HeaderButtonContentItem
   {
       
      
      public var doItTextField:TextField = null;
      
      public var buttonActionContent:HeaderButtonActionContent = null;
      
      public function HBC_ActionItem()
      {
         super();
      }
      
      override public function updateButtonBounds(param1:Rectangle) : void
      {
         if(this.buttonActionContent != null)
         {
            this.buttonActionContent.updateSize(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this.doItTextField = null;
         if(this.buttonActionContent != null && contains(this.buttonActionContent))
         {
            removeChild(this.buttonActionContent);
         }
         this.buttonActionContent = null;
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:String = null;
         if(this.isDiscountEnabled())
         {
            if(this.buttonActionContent == null)
            {
               this.buttonActionContent = App.utils.classFactory.getComponent(Linkages.HEADER_BUTTON_ACTION_CONTENT,HeaderButtonActionContent);
            }
            if(this.buttonActionContent != null && !contains(this.buttonActionContent))
            {
               addChildAt(this.buttonActionContent,0);
            }
         }
         else
         {
            if(this.buttonActionContent != null && contains(this.buttonActionContent))
            {
               removeChild(this.buttonActionContent);
            }
            this.buttonActionContent = null;
         }
         if(this.buttonActionContent != null)
         {
            this.buttonActionContent.setEnabled(this.isDiscountEnabled());
         }
         if(needUpdateFontSize)
         {
            updateFontSize(this.doItTextField,useFontSize);
         }
         if(!this.needForsTextStyle())
         {
            _loc1_ = !!this.isDiscountEnabled() ? TEXT_MANAGER_STYLES.STATS_TEXT : TEXT_MANAGER_STYLES.MAIN_TEXT;
            this.doItTextField.htmlText = App.textMgr.getTextStyleById(_loc1_,this.doItTextField.text);
         }
         this.doItTextField.width = this.doItTextField.textWidth + TEXT_FIELD_MARGIN;
         super.updateData();
      }
      
      protected function isDiscountEnabled() : Boolean
      {
         return false;
      }
      
      protected function needForsTextStyle() : Boolean
      {
         return false;
      }
   }
}
