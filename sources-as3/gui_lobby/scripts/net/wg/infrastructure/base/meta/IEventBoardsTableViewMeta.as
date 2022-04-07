package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBoardsTableViewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function setMyPlaceS() : void;
      
      function participateStatusClickS() : void;
      
      function playerClickS(param1:Number) : void;
      
      function showNextAwardS(param1:Boolean) : void;
      
      function as_setHeaderData(param1:Object) : void;
      
      function as_setStatusData(param1:Object) : void;
      
      function as_setTableData(param1:Object) : void;
      
      function as_setTableHeaderData(param1:Object) : void;
      
      function as_setBackground(param1:String) : void;
      
      function as_setScrollPos(param1:int, param2:Boolean) : void;
      
      function as_setMyPlaceVisible(param1:Boolean) : void;
      
      function as_setMyPlace(param1:int) : void;
      
      function as_setMyPlaceTooltip(param1:String) : void;
      
      function as_setStatusVisible(param1:Boolean) : void;
      
      function as_setWaiting(param1:Boolean, param2:String) : void;
      
      function as_setMaintenance(param1:Boolean, param2:String, param3:String, param4:String) : void;
      
      function as_setAwardsStripes(param1:Object) : void;
      
      function as_setEmptyData(param1:String) : void;
   }
}
