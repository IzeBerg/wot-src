package net.wg.infrastructure.interfaces
{
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface IListDAAPIDataProvider extends IDAAPISortable, IDataProvider, IDAAPIModule
   {
       
      
      function invalidateItem(param1:int, param2:Object) : void;
      
      function invalidateItems(param1:Array, param2:Array) : void;
      
      function getItemIndex(param1:String, param2:*) : int;
      
      function resetSelectedIndex(param1:int) : void;
      
      function get maxCacheSize() : int;
      
      function set maxCacheSize(param1:int) : void;
   }
}
