package net.wg.gui.battle.views.questProgress.interfaces
{
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQuestProgressDataHub extends IDisposable
   {
       
      
      function getData() : Vector.<IQuestProgressItemData>;
   }
}
