package net.wg.gui.lobby.fortifications.data.battleRoom
{
   import net.wg.gui.rally.vo.RallySlotVO;
   
   public class SortieSlotVO extends RallySlotVO
   {
       
      
      public var isMatchingEnabled:Boolean = false;
      
      public var isFiltersEnabled:Boolean = false;
      
      public var filterState:int = -1;
      
      public var vehicles:Array = null;
      
      public function SortieSlotVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.vehicles)
         {
            this.vehicles.splice(0,this.vehicles.length);
            this.vehicles = null;
         }
         super.onDispose();
      }
   }
}
