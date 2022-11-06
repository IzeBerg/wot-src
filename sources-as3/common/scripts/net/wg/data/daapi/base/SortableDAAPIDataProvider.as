package net.wg.data.daapi.base
{
   import net.wg.infrastructure.interfaces.IDAAPISortable;
   
   public class SortableDAAPIDataProvider extends DAAPIDataProvider implements IDAAPISortable
   {
       
      
      public var sortOnHandler:Function;
      
      public var getSelectedIdxHandler:Function;
      
      public function SortableDAAPIDataProvider()
      {
         super();
      }
      
      public function DAAPIsortOn(param1:Object, param2:Object) : Array
      {
         if(this.sortOnHandler != null)
         {
            return this.sortOnHandler(param1,param2);
         }
         return [];
      }
      
      public function getDAAPIselectedIdx() : int
      {
         if(this.getSelectedIdxHandler != null)
         {
            return this.getSelectedIdxHandler();
         }
         return -1;
      }
   }
}
