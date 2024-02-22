package net.wg.gui.lobby.components.interfaces
{
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IStoppableAnimationItem extends IStoppableAnimation, IDisposable, IDisplayObject
   {
       
      
      function setImage(param1:String) : void;
   }
}
