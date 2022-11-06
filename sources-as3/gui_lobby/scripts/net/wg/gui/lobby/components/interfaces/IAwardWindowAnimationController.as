package net.wg.gui.lobby.components.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IAwardWindowAnimationController extends IDisposable
   {
       
      
      function registerAnimation(param1:IAwardWindowAnimationWrapper) : void;
      
      function unregisterAnimation(param1:IAwardWindowAnimationWrapper) : void;
   }
}
