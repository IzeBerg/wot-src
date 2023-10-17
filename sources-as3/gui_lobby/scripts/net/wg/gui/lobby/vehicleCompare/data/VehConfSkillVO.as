package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehConfSkillVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var skillType:String = "";
      
      public var skillRole:String = "";
      
      public var selected:Boolean = false;
      
      public var skillLevel:Number = -1;
      
      public function VehConfSkillVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
