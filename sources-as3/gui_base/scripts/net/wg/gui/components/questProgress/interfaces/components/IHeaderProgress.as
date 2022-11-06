package net.wg.gui.components.questProgress.interfaces.components
{
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IHeaderProgress extends IUIComponentEx
   {
       
      
      function setData(param1:IHeaderProgressData, param2:int) : void;
   }
}
