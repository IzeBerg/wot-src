package net.wg.gui.battle.views.damagePanel.components.statusIndicator
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StatusArrow extends MovieClip implements IDisposable
   {
      
      public static const STATE_SHOW:String = "show";
      
      public static const STATE_BASE:String = "base";
      
      public static const STATE_HIDDEN:String = "hidden";
       
      
      private var _disposed:Boolean = false;
      
      public function StatusArrow()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
      }
      
      public function showStatus(param1:Boolean = true) : void
      {
         if(param1)
         {
            gotoAndPlay(STATE_SHOW);
         }
         else
         {
            gotoAndStop(STATE_BASE);
         }
      }
      
      public function hideStatus() : void
      {
         stop();
         gotoAndStop(STATE_HIDDEN);
      }
      
      public function isVisible() : Boolean
      {
         return visible || currentFrameLabel != STATE_HIDDEN;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
