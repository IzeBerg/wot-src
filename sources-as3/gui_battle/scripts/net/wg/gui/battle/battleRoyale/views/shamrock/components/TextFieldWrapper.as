package net.wg.gui.battle.battleRoyale.views.shamrock.components
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class TextFieldWrapper extends BattleUIComponent
   {
       
      
      public var textField:TextField = null;
      
      public function TextFieldWrapper()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         this.textField.text = param1;
      }
   }
}
