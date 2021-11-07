package net.wg.gui.components.carousels.data
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class FilterRoleInitVO extends DAAPIDataClass
   {
      
      private static const LIGHT_TANK_FIELD:String = "lightTank";
      
      private static const MEDIUM_TANK_FIELD:String = "mediumTank";
      
      private static const HEAVY_TANK_FIELD:String = "heavyTank";
      
      private static const AT_SPG_FIELD:String = "AT-SPG";
       
      
      private var _lightTank:DataProvider = null;
      
      private var _mediumTank:DataProvider = null;
      
      private var _heavyTank:DataProvider = null;
      
      private var _AT_SPG:DataProvider = null;
      
      private var _vehicleTypesMap:Dictionary = null;
      
      public function FilterRoleInitVO(param1:Object)
      {
         super(param1);
         this._vehicleTypesMap = new Dictionary(true);
         this._vehicleTypesMap[VehicleTypes.LIGHT_TANK] = this._lightTank;
         this._vehicleTypesMap[VehicleTypes.MEDIUM_TANK] = this._mediumTank;
         this._vehicleTypesMap[VehicleTypes.HEAVY_TANK] = this._heavyTank;
         this._vehicleTypesMap[VehicleTypes.AT_SPG] = this._AT_SPG;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == LIGHT_TANK_FIELD)
         {
            this._lightTank = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._lightTank.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == MEDIUM_TANK_FIELD)
         {
            this._mediumTank = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._mediumTank.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == HEAVY_TANK_FIELD)
         {
            this._heavyTank = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._heavyTank.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == AT_SPG_FIELD)
         {
            this._AT_SPG = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._AT_SPG.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         App.instance.utils.data.cleanupDynamicObject(this._vehicleTypesMap);
         this._vehicleTypesMap = null;
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._lightTank)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._mediumTank)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._heavyTank)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._AT_SPG)
         {
            _loc1_.dispose();
         }
         this._lightTank.cleanUp();
         this._lightTank = null;
         this._mediumTank.cleanUp();
         this._mediumTank = null;
         this._heavyTank.cleanUp();
         this._heavyTank = null;
         this._AT_SPG.cleanUp();
         this._AT_SPG = null;
         super.onDispose();
      }
      
      public function getDataProvider(param1:String) : DataProvider
      {
         return this._vehicleTypesMap[param1];
      }
   }
}
