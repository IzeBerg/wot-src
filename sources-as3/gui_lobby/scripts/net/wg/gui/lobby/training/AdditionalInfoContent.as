package net.wg.gui.lobby.training
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AdditionalInfoContent extends Sprite implements IDisposable
   {
      
      public static const LAYOUT_SMALL:uint = 0;
      
      public static const LAYOUT_SMALL_WITH_TEXT_AND_SEPARATOR:uint = 1;
      
      public static const LAYOUT_BIG:uint = 2;
       
      
      private var _baseDisposed:Boolean = false;
      
      public function AdditionalInfoContent()
      {
         super();
      }
      
      public function setLayout(param1:uint) : void
      {
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      protected function onDispose() : void
      {
      }
   }
}
