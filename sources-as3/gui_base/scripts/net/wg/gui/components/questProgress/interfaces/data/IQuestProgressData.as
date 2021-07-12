package net.wg.gui.components.questProgress.interfaces.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQuestProgressData extends IDisposable
   {
       
      
      function getData() : Vector.<IQuestProgressItemData>;
      
      function getDataItem(param1:String) : IQuestProgressItemData;
      
      function get headerConditions() : Vector.<IHeaderProgressData>;
      
      function get questName() : String;
      
      function get questIndexStr() : String;
      
      function get questIcon() : String;
      
      function get isQPActive() : Boolean;
      
      function get questID() : int;
      
      function get isHeaderHasProgress() : Boolean;
   }
}
