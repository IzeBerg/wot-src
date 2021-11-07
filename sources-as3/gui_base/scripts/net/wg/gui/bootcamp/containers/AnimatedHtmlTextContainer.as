package net.wg.gui.bootcamp.containers
{
   public class AnimatedHtmlTextContainer extends AnimatedTextContainer
   {
       
      
      public function AnimatedHtmlTextContainer()
      {
         super();
      }
      
      override public function get text() : String
      {
         return textField.htmlText;
      }
      
      override public function set text(param1:String) : void
      {
         textField.htmlText = param1;
      }
   }
}
