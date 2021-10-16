package net.wg.gui.battle.views.ribbonsPanel
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationSet extends MovieClip implements IDisposable
   {
       
      
      public var wrapper:MovieClip = null;
      
      public var glowAnim:MovieClip = null;
      
      public function AnimationSet()
      {
         super();
         this.glowAnim.gotoAndStop(this.glowAnim.totalFrames - 1);
      }
      
      public function init(param1:MovieClip) : void
      {
         this.wrapper.addChild(param1);
      }
      
      public final function dispose() : void
      {
         this.glowAnim = null;
         this.wrapper = null;
      }
   }
}
