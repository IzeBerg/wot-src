package net.wg.gui.battle.views.battleTankCarousel.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class BattleVehicleCarouselVO extends DAAPIUpdatableDataClass
   {
       
      
      public var vehicleID:int = -1;
      
      public var flagIcon:String = "";
      
      public var vehicleIcon:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var vehicleLevelIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var isElite:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var favorite:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public var cooldown:String = "";
      
      public var settings:int = -1;
      
      public function BattleVehicleCarouselVO(param1:Object)
      {
         super(param1);
      }
   }
}
