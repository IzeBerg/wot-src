package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleRendererItemVO extends DAAPIDataClass
   {
       
      
      public var shortUserName:String = "";
      
      public var type:String = "";
      
      public var typeIcon:String = "";
      
      public var level:int = -1;
      
      public var nationID:int = -1;
      
      public var dbID:int = -1;
      
      public var smallIconPath:String = "";
      
      public var selected:Boolean = false;
      
      public var inHangar:Boolean = false;
      
      public function VehicleRendererItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
