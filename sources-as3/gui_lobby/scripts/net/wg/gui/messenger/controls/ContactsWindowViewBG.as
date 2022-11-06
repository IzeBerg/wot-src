package net.wg.gui.messenger.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ContactsWindowViewBG extends UIComponentEx
   {
       
      
      public var hit:MovieClip;
      
      public var bgForm:Sprite;
      
      public function ContactsWindowViewBG()
      {
         super();
         hitArea = this.hit;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bgForm.width = _width - this.bgForm.x * 2;
            this.bgForm.height = _height - this.bgForm.y * 2;
         }
      }
   }
}
