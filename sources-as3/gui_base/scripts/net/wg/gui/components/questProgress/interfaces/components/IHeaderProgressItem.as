package net.wg.gui.components.questProgress.interfaces.components
{
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IHeaderProgressItem extends IUIComponentEx
   {
       
      
      function setData(param1:IHeaderProgressData, param2:int) : void;
      
      function update(param1:IHeaderProgressData) : void;
      
      function get orderType() : String;
   }
}
