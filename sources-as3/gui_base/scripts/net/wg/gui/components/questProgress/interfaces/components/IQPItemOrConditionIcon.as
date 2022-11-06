package net.wg.gui.components.questProgress.interfaces.components
{
   import net.wg.infrastructure.interfaces.ISprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQPItemOrConditionIcon extends ISprite, IDisposable
   {
       
      
      function setItems(param1:IQPItemRenderer, param2:IQPItemRenderer) : void;
      
      function get item() : IQPItemRenderer;
      
      function get previousItem() : IQPItemRenderer;
   }
}
