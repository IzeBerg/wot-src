package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.hangar.crew.TankmanVO;
   
   public class VPCrewRendererVO extends DAAPIDataClass
   {
      
      private static const TANKMAN_PROP_NAME:String = "tankman";
       
      
      public var icon:String = "";
      
      public var name:String = "";
      
      public var tooltip:String = "";
      
      public var role:String = "";
      
      public var crewId:Number = -1;
      
      public var tankman:TankmanVO;
      
      public function VPCrewRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TANKMAN_PROP_NAME)
         {
            this.tankman = new TankmanVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.tankman != null)
         {
            this.tankman.dispose();
            this.tankman = null;
         }
         super.onDispose();
      }
   }
}
