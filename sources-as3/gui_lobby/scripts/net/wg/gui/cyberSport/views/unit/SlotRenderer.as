package net.wg.gui.cyberSport.views.unit
{
   import flash.text.TextField;
   import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
   import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySlotWithRating;
   import net.wg.gui.rally.vo.RallySlotVO;
   import scaleform.clik.events.ButtonEvent;
   
   public class SlotRenderer extends RallyLockableSlotRenderer implements IRallySlotWithRating
   {
       
      
      public var ratingTF:TextField;
      
      public var levelLbl:TextField;
      
      public function SlotRenderer()
      {
         super();
         badgeOffsetY = -4;
      }
      
      override protected function onDispose() : void
      {
         this.ratingTF = null;
         this.levelLbl = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         userInfoTextLoadingController.setControlledUserRatingTextField(this.ratingTF);
      }
      
      public function setRatingLabelHtmlText(param1:String) : void
      {
         if(userInfoTextLoadingController != null)
         {
            userInfoTextLoadingController.setUserRatingHtmlText(param1);
         }
      }
      
      public function get unitSlotData() : RallySlotVO
      {
         return slotData as RallySlotVO;
      }
      
      public function get ratingTextField() : TextField
      {
         return this.ratingTF;
      }
      
      public function get slotLabelTextField() : TextField
      {
         return slotLabel.textField;
      }
      
      override protected function onRemoveClick(param1:ButtonEvent) : void
      {
         if(this.unitSlotData)
         {
            if(this.unitSlotData.player)
            {
               super.onRemoveClick(param1);
            }
            else if(index > 4)
            {
               dispatchEvent(new CSComponentEvent(CSComponentEvent.LOCK_SLOT_REQUEST,index));
            }
         }
      }
   }
}
