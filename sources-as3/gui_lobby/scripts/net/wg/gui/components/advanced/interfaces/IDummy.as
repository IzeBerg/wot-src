package net.wg.gui.components.advanced.interfaces
{
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IDummy extends IUIComponentEx, IFocusChainContainer
   {
       
      
      function setData(param1:DummyVO) : void;
   }
}
