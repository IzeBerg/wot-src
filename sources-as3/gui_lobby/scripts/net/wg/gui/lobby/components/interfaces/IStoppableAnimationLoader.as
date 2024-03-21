package net.wg.gui.lobby.components.interfaces
{
   import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IStoppableAnimationLoader extends IStoppableAnimation, IDisposable, IDisplayObject
   {
       
      
      function setData(param1:StoppableAnimationLoaderVO) : void;
   }
}
