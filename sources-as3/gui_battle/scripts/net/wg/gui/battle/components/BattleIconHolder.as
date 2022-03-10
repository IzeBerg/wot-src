package net.wg.gui.battle.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleIconHolder extends Sprite implements IDisposable
   {
       
      
      protected var _baseDisposed:Boolean = false;
      
      private var _currItem:DisplayObject = null;
      
      public function BattleIconHolder()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._baseDisposed = true;
         this._currItem = null;
         this.onDispose();
      }
      
      public function hide() : void
      {
         if(this._currItem)
         {
            this._currItem.visible = false;
            this._currItem = null;
         }
      }
      
      protected function onDispose() : void
      {
      }
      
      protected function showItem(param1:DisplayObject) : void
      {
         if(this._currItem != param1)
         {
            this.hide();
            this._currItem = param1;
            this._currItem.visible = true;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
