package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.interfaces.IUIComponent;
   
   public interface IViewStackContent extends IUpdatable, IFocusContainer, IUIComponent
   {
       
      
      function canShowAutomatically() : Boolean;
   }
}
