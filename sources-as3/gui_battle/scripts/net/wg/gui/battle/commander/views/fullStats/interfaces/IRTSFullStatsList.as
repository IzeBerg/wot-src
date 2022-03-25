package net.wg.gui.battle.commander.views.fullStats.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IRTSFullStatsList extends IDisposable, IEventDispatcher, IDisplayObject
   {
       
      
      function updateOrder(param1:Vector.<Number>) : void;
      
      function getItemByID(param1:Number) : IRTSFullStatsItem;
      
      function setData(param1:Vector.<IDAAPIDataClass>) : void;
      
      function setHeaderText(param1:String) : void;
      
      function removeAllItems() : void;
      
      function setFrags(param1:Number, param2:int) : void;
      
      function resetFrags() : void;
   }
}
