package net.wg.gui.lobby.profile.pages.technique.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TechniqueListVehicleVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var inventoryID:int = -1;
      
      public var nationID:int = -1;
      
      public var isInHangar:Boolean = false;
      
      public var shortUserName:String = "";
      
      public var userName:String = "";
      
      public var battlesCount:int = -1;
      
      public var winsEfficiency:Number = 0;
      
      public var winsEfficiencyStr:String = "";
      
      public var avgExperience:Number = 0;
      
      public var nationIndex:int = -1;
      
      public var typeIconPath:String = "";
      
      public var tankIconPath:String = "";
      
      public var typeIndex:int = -1;
      
      public var markOfMastery:int = -1;
      
      public var markOfMasteryBlock:String = "";
      
      public var level:int = -1;
      
      public var compareModeAvailable:Boolean = false;
      
      public var avgDamage:Number = 0;
      
      public var avgFrags:Number = 0;
      
      public var winsCount:int = -1;
      
      public function TechniqueListVehicleVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get nationIconPath() : String
      {
         return App.utils.nations.getNationIcon(this.nationID);
      }
   }
}
