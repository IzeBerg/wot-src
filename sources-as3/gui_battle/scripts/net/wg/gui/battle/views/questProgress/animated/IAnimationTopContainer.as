package net.wg.gui.battle.views.questProgress.animated
{
   import net.wg.infrastructure.interfaces.IDisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IAnimationTopContainer extends IDisposable, IDisplayObjectContainer
   {
       
      
      function hide() : void;
      
      function show() : void;
      
      function reset() : void;
   }
}
