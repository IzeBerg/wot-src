package net.wg.gui.battle.views.damagePanel.components.stunIndicator
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StunArrow extends MovieClip implements IDisposable
   {
      
      public static const STATE_SHOW:String = "show";
      
      public static const STATE_BASE:String = "base";
      
      public static const STATE_HIDDEN:String = "hidden";
      
      public static const STATE_HIDE:String = "hide";
       
      
      public function StunArrow()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public final function dispose() : void
      {
         stop();
      }
      
      public function showStun(param1:Boolean = true) : void
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
      
      public function hideStun(param1:Boolean = true) : void
      {
         stop();
         if(param1)
         {
            gotoAndPlay(STATE_HIDE);
         }
         else
         {
            gotoAndStop(STATE_HIDDEN);
         }
      }
      
      public function isVisible() : Boolean
      {
         return visible || currentFrameLabel != STATE_HIDDEN;
      }
   }
}
