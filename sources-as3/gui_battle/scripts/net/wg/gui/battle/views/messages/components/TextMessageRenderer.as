package net.wg.gui.battle.views.messages.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class TextMessageRenderer extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField;
      
      public var background:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      public function TextMessageRenderer()
      {
         super();
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         this.background = null;
         this.textField = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
