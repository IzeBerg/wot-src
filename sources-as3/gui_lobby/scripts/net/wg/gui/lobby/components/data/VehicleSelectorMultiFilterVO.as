package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import scaleform.clik.data.DataProvider;
   
   public class VehicleSelectorMultiFilterVO extends VehicleSelectorFilterVO
   {
      
      private static const TOGGLES_DP:String = "togglesDP";
       
      
      public var togglesDP:DataProvider = null;
      
      public function VehicleSelectorMultiFilterVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == TOGGLES_DP)
         {
            this.togglesDP = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.togglesDP.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.togglesDP.cleanUp();
         this.togglesDP = null;
         super.onDispose();
      }
   }
}
