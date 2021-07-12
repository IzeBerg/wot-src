package net.wg.gui.components.questProgress.interfaces.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQuestProgressItemData extends IDisposable
   {
       
      
      function parseProgressData(param1:Object) : IQPProgressData;
      
      function updateProgressData(param1:IQPProgressData) : void;
      
      function get id() : String;
      
      function get initData() : IQPInitData;
      
      function get progressData() : IQPProgressData;
   }
}
