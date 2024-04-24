package net.wg.gui.lobby.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ICommons;
   
   public class IconTextWrapper extends UIComponentEx implements IDisposable
   {
      
      private static const INV_POS:String = "invPosition";
      
      private static const GAP:int = 15;
       
      
      public var textField:TextField = null;
      
      public var icon:Sprite = null;
      
      private var _commons:ICommons;
      
      public function IconTextWrapper()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_POS))
         {
            this._commons.updateTextFieldSize(this.textField,true,false);
            if(this.icon)
            {
               this.icon.x = this.textField.width + GAP | 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.icon = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function getTextFormat() : TextFormat
      {
         return this.textField.getTextFormat();
      }
      
      public function setHtmlText(param1:String) : void
      {
         this.textField.htmlText = param1;
         invalidate(INV_POS);
      }
      
      public function setText(param1:String) : void
      {
         this.textField.text = param1;
         invalidate(INV_POS);
      }
      
      public function setTextFormat(param1:TextFormat) : void
      {
         this.textField.setTextFormat(param1);
         invalidate(INV_POS);
      }
   }
}
