package net.wg.gui.battle.comp7.views.battleTankCarousel.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class BattleVehicleCarouselVO extends DAAPIUpdatableDataClass
   {
       
      
      public var flagIcon:String = "";
      
      public var flagIconSmall:String = "";
      
      public var vehicleIcon:String = "";
      
      public var vehicleIconSmall:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var vehicleTypeIconSmall:String = "";
      
      public var vehicleName:String = "";
      
      public var favorite:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public var roleName:String = "";
      
      public function BattleVehicleCarouselVO(param1:Object)
      {
         super(param1);
      }
   }
}
