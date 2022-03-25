package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialHintText extends Sprite implements IDisposable
   {
       
      
      public var hintTF:TextField = null;
      
      private var _isDisposed:Boolean = false;
      
      public function TutorialHintText()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.hintTF = null;
         this._isDisposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
