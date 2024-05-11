package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.AnimationIcon;
   import net.wg.gui.lobby.components.interfaces.IStoppableAnimationItem;
   
   public class ExplosionAwardWindowAnimation extends MovieClip implements IStoppableAnimationItem
   {
       
      
      public var shineIcon:AnimationIcon;
      
      public var mainIcon:AnimationIcon;
      
      private var _disposed:Boolean = false;
      
      public function ExplosionAwardWindowAnimation()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.shineIcon.dispose();
         this.shineIcon = null;
         this.mainIcon.dispose();
         this.mainIcon = null;
      }
      
      public function setImage(param1:String) : void
      {
         this.shineIcon.setImage(param1);
         this.mainIcon.setImage(param1);
      }
      
      public function stopAnimation() : void
      {
         gotoAndStop(totalFrames);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
