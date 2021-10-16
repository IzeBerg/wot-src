package net.wg.gui.battle.views.questProgress.interfaces
{
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQuestProgressViewUpdatable extends IDisposable
   {
       
      
      function init(param1:IQuestProgressData) : void;
      
      function update(param1:String, param2:IQPProgressData) : void;
      
      function updateHeaderProgress(param1:Vector.<IHeaderProgressData>) : void;
      
      function findItemById(param1:String) : IQPItemRenderer;
   }
}
