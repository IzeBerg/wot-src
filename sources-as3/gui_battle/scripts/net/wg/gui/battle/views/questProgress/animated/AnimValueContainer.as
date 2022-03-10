package net.wg.gui.battle.views.questProgress.animated
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimValueContainer extends Sprite implements IDisposable
   {
       
      
      public var valueTf:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimValueContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.valueTf = null;
      }
      
      public function setValue(param1:String, param2:uint) : void
      {
         this.valueTf.text = param1;
         this.valueTf.textColor = param2;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
