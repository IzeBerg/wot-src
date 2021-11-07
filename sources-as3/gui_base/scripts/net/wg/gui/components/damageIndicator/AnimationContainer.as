package net.wg.gui.components.damageIndicator
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationContainer extends MovieClip implements IDisposable
   {
       
      
      public var stateContainer:StandardStateContainer = null;
      
      public function AnimationContainer()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.stateContainer.dispose();
         this.stateContainer = null;
      }
      
      public function rotateInfo(param1:Number) : void
      {
         this.stateContainer.rotateInfo(param1);
      }
   }
}
