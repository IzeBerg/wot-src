package net.wg.gui.components.advanced.tutorial
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialHintText extends Sprite implements IDisposable
   {
       
      
      public var hintTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TutorialHintText()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.hintTF = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
