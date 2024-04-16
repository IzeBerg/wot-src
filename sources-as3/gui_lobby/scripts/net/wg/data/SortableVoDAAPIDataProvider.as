package net.wg.data
{
   import net.wg.infrastructure.interfaces.IDAAPISortable;
   
   public class SortableVoDAAPIDataProvider extends VoDAAPIDataProvider implements IDAAPISortable
   {
       
      
      public var sortOnHandler:Function;
      
      public var getSelectedIdxHandler:Function;
      
      public function SortableVoDAAPIDataProvider(param1:Class)
      {
         super(param1);
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
