package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class VehParamsDataVO extends DAAPIUpdatableDataClass
   {
       
      
      public var paramID:String = "";
      
      public var text:String = "";
      
      public var state:String = "";
      
      public var isVisible:Boolean = true;
      
      public function VehParamsDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
