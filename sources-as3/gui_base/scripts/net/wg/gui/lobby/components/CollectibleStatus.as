package net.wg.gui.lobby.components
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.gfx.TextFieldEx;
   
   public class CollectibleStatus extends UIComponentEx
   {
      
      private static const ICON_SIZE:int = 35;
       
      
      public var textField:TextField;
      
      public function CollectibleStatus()
      {
         super();
         this.textField.text = STORE.CONGRATULATIONANIM_COLLECTIBLELABEL;
         TextFieldEx.setVerticalAlign(this.textField,TextFieldEx.VALIGN_CENTER);
      }
      
      override public function get width() : Number
      {
         return ICON_SIZE + this.textField.textWidth;
      }
   }
}
