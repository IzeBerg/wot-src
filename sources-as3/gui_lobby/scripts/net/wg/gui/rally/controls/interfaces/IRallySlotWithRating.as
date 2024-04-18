package net.wg.gui.rally.controls.interfaces
{
   import flash.text.TextField;
   
   public interface IRallySlotWithRating
   {
       
      
      function setRatingLabelHtmlText(param1:String) : void;
      
      function get ratingTextField() : TextField;
      
      function get slotLabelTextField() : TextField;
   }
}
