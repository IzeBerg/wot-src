package net.wg.gui.battle.views.destroyTimers.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class TimerContainer extends MovieClip implements IDisposable
   {
       
      
      public var progressBar:MovieClip = null;
      
      public var iconSpr:Sprite = null;
      
      public var textField:TextField = null;
      
      public function TimerContainer()
      {
         super();
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      protected function onDispose() : void
      {
         this.progressBar = null;
         this.iconSpr = null;
         this.textField = null;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
   }
}
