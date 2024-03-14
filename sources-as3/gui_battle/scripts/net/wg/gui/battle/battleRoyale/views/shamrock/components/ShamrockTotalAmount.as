package net.wg.gui.battle.battleRoyale.views.shamrock.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.ICommons;
   
   public class ShamrockTotalAmount extends BattleUIComponent
   {
      
      private static const ICON_WIDTH:int = 20;
      
      private static const GAP:int = 5;
       
      
      public var valueTF:TextField = null;
      
      public var icon:Sprite = null;
      
      private var _commons:ICommons;
      
      private var _value:int = 0;
      
      public function ShamrockTotalAmount()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override protected function onDispose() : void
      {
         this.valueTF = null;
         this.icon = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.valueTF.text = this._value.toString();
            this._commons.updateTextFieldSize(this.valueTF);
            this.icon.x = -this.width >> 1;
            this.valueTF.x = this.icon.x + ICON_WIDTH + GAP;
         }
      }
      
      public function getRightOffset() : int
      {
         return this.valueTF.x + this.valueTF.width;
      }
      
      public function setValue(param1:int) : void
      {
         if(this._value != param1)
         {
            this._value = param1;
            invalidateData();
         }
      }
      
      override public function get width() : Number
      {
         return this.valueTF.width + ICON_WIDTH + GAP;
      }
   }
}
