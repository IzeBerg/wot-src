package net.wg.gui.messenger.controls
{
   public class ContactsListHighlightArea extends DashedHighlightArea
   {
       
      
      public function ContactsListHighlightArea()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         bgAlpha = 0.1;
         dashLength = 4;
         gap = 7;
      }
      
      public function setDefColor(param1:Boolean) : void
      {
         var _loc2_:uint = 39168;
         var _loc3_:uint = 16711680;
         bgColor = color = !!param1 ? uint(_loc2_) : uint(_loc3_);
      }
   }
}
