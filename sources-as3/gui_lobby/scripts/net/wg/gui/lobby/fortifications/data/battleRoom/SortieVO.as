package net.wg.gui.lobby.fortifications.data.battleRoom
{
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.rally.vo.RallyVO;
   
   public class SortieVO extends RallyVO
   {
       
      
      private var _divisionLbl:String = "";
      
      public function SortieVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function initSlotsVO(param1:Object) : void
      {
         var _loc3_:Object = null;
         var _loc4_:SortieSlotVO = null;
         slots = new Vector.<IRallySlotVO>();
         var _loc2_:Array = param1 as Array;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = new SortieSlotVO(_loc3_);
            slots.push(_loc4_);
         }
      }
      
      public function get divisionLbl() : String
      {
         return this._divisionLbl;
      }
      
      public function set divisionLbl(param1:String) : void
      {
         this._divisionLbl = param1;
      }
   }
}
