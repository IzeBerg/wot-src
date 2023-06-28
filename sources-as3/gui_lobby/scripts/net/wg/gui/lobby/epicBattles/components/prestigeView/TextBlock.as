package net.wg.gui.lobby.epicBattles.components.prestigeView
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TextBlock extends UIComponentEx
   {
       
      
      public var descriptionTF:TextField = null;
      
      public var titleTF:TextField = null;
      
      public function TextBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.descriptionTF = null;
         super.onDispose();
      }
      
      public function setDescription(param1:String) : void
      {
         this.descriptionTF.text = param1;
      }
      
      public function setTitle(param1:String) : void
      {
         this.titleTF.text = param1;
      }
   }
}
