package net.wg.gui.lobby.fortifications.data.popover
{
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.gui.lobby.components.data.VehicleSelectorMultiFilterVO;
   
   public class FortVehicleSelectorFilterVO extends VehicleSelectorMultiFilterVO
   {
      
      private static const MAIN_BTN:String = "mainBtn";
       
      
      public var mainBtn:SimpleRendererVO = null;
      
      public var nationTooltip:String = "";
      
      public function FortVehicleSelectorFilterVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == MAIN_BTN)
         {
            this.mainBtn = new SimpleRendererVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.mainBtn)
         {
            this.mainBtn.dispose();
            this.mainBtn = null;
         }
         super.onDispose();
      }
   }
}
