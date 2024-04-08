package net.wg.gui.battle.pveBase.views.minimap
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class PveMinimapShortcutLabel extends BattleUIComponent
   {
       
      
      public var textField:TextField;
      
      public var background:Sprite;
      
      private var _right:Number;
      
      public function PveMinimapShortcutLabel()
      {
         super();
         TextFieldEx.setNoTranslate(this.textField,true);
         this._right = this.background.width - this.textField.x - this.textField.width;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function setText(param1:String) : void
      {
         this.textField.text = param1;
         this.background.width = this.textField.x + this.textField.width + this._right;
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.background = null;
         super.onDispose();
      }
   }
}
