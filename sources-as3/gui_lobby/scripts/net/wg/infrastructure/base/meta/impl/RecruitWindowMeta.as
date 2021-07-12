package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class RecruitWindowMeta extends AbstractWindowView
   {
       
      
      public var updateVehicleClassDropdown:Function;
      
      public var updateVehicleTypeDropdown:Function;
      
      public var updateRoleDropdown:Function;
      
      public var updateNationDropdown:Function;
      
      public var buyTankman:Function;
      
      public var updateAllDropdowns:Function;
      
      private var _dataProvider:DataProvider;
      
      private var _dataProvider1:DataProvider;
      
      private var _dataProvider2:DataProvider;
      
      private var _dataProvider3:DataProvider;
      
      private var _dataProvider4:DataProvider;
      
      private var _dataProvider5:DataProvider;
      
      private var _dataProvider6:DataProvider;
      
      private var _dataProvider7:DataProvider;
      
      public function RecruitWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dataProvider)
         {
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         if(this._dataProvider1)
         {
            this._dataProvider1.cleanUp();
            this._dataProvider1 = null;
         }
         if(this._dataProvider2)
         {
            this._dataProvider2.cleanUp();
            this._dataProvider2 = null;
         }
         if(this._dataProvider3)
         {
            this._dataProvider3.cleanUp();
            this._dataProvider3 = null;
         }
         if(this._dataProvider4)
         {
            this._dataProvider4.cleanUp();
            this._dataProvider4 = null;
         }
         if(this._dataProvider5)
         {
            this._dataProvider5.cleanUp();
            this._dataProvider5 = null;
         }
         if(this._dataProvider6)
         {
            this._dataProvider6.cleanUp();
            this._dataProvider6 = null;
         }
         if(this._dataProvider7)
         {
            this._dataProvider7.cleanUp();
            this._dataProvider7 = null;
         }
         super.onDispose();
      }
      
      public function updateVehicleClassDropdownS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.updateVehicleClassDropdown,"updateVehicleClassDropdown" + Errors.CANT_NULL);
         this.updateVehicleClassDropdown(param1);
      }
      
      public function updateVehicleTypeDropdownS(param1:Number, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.updateVehicleTypeDropdown,"updateVehicleTypeDropdown" + Errors.CANT_NULL);
         this.updateVehicleTypeDropdown(param1,param2);
      }
      
      public function updateRoleDropdownS(param1:Number, param2:String, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.updateRoleDropdown,"updateRoleDropdown" + Errors.CANT_NULL);
         this.updateRoleDropdown(param1,param2,param3);
      }
      
      public function updateNationDropdownS() : void
      {
         App.utils.asserter.assertNotNull(this.updateNationDropdown,"updateNationDropdown" + Errors.CANT_NULL);
         this.updateNationDropdown();
      }
      
      public function buyTankmanS(param1:Number, param2:Number, param3:String, param4:Number, param5:Number) : void
      {
         App.utils.asserter.assertNotNull(this.buyTankman,"buyTankman" + Errors.CANT_NULL);
         this.buyTankman(param1,param2,param3,param4,param5);
      }
      
      public function updateAllDropdownsS(param1:Number, param2:String, param3:Number, param4:String) : void
      {
         App.utils.asserter.assertNotNull(this.updateAllDropdowns,"updateAllDropdowns" + Errors.CANT_NULL);
         this.updateAllDropdowns(param1,param2,param3,param4);
      }
      
      public final function as_setVehicleClassDropdown(param1:Array) : void
      {
         var _loc2_:DataProvider = this._dataProvider;
         this._dataProvider = new DataProvider(param1);
         this.setVehicleClassDropdown(this._dataProvider);
         if(_loc2_)
         {
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setVehicleTypeDropdown(param1:Array) : void
      {
         var _loc2_:DataProvider = this._dataProvider1;
         this._dataProvider1 = new DataProvider(param1);
         this.setVehicleTypeDropdown(this._dataProvider1);
         if(_loc2_)
         {
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setRoleDropdown(param1:Array) : void
      {
         var _loc2_:DataProvider = this._dataProvider2;
         this._dataProvider2 = new DataProvider(param1);
         this.setRoleDropdown(this._dataProvider2);
         if(_loc2_)
         {
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setNations(param1:Array) : void
      {
         var _loc2_:DataProvider = this._dataProvider3;
         this._dataProvider3 = new DataProvider(param1);
         this.setNations(this._dataProvider3);
         if(_loc2_)
         {
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setAllDropdowns(param1:Array, param2:Array, param3:Array, param4:Array) : void
      {
         var _loc5_:DataProvider = this._dataProvider4;
         this._dataProvider4 = new DataProvider(param1);
         var _loc6_:DataProvider = this._dataProvider5;
         this._dataProvider5 = new DataProvider(param2);
         var _loc7_:DataProvider = this._dataProvider6;
         this._dataProvider6 = new DataProvider(param3);
         var _loc8_:DataProvider = this._dataProvider7;
         this._dataProvider7 = new DataProvider(param4);
         this.setAllDropdowns(this._dataProvider4,this._dataProvider5,this._dataProvider6,this._dataProvider7);
         if(_loc5_)
         {
            _loc5_.cleanUp();
         }
         if(_loc6_)
         {
            _loc6_.cleanUp();
         }
         if(_loc7_)
         {
            _loc7_.cleanUp();
         }
         if(_loc8_)
         {
            _loc8_.cleanUp();
         }
      }
      
      protected function setVehicleClassDropdown(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setVehicleClassDropdown" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehicleTypeDropdown(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setVehicleTypeDropdown" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRoleDropdown(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setRoleDropdown" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setNations(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setNations" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAllDropdowns(param1:DataProvider, param2:DataProvider, param3:DataProvider, param4:DataProvider) : void
      {
         var _loc5_:String = "as_setAllDropdowns" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc5_);
         throw new AbstractException(_loc5_);
      }
   }
}
