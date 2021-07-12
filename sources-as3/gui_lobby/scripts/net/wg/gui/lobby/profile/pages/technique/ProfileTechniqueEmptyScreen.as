package net.wg.gui.lobby.profile.pages.technique
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileTechniqueEmptyScreen extends UIComponentEx
   {
       
      
      private var _text:String = "";
      
      public var textField:TextField;
      
      public function ProfileTechniqueEmptyScreen()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textField.text = this._text;
         }
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         invalidateData();
      }
   }
}
