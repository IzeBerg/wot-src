package net.wg.infrastructure.base
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.IAnimation;
   
   public class Animation extends MovieClip implements IAnimation
   {
       
      
      public var target:MovieClip = null;
      
      public function Animation()
      {
         super();
      }
      
      public function getTarget() : MovieClip
      {
         return this.target;
      }
      
      public function setTarget(param1:MovieClip) : void
      {
         this.target = param1;
      }
   }
}
