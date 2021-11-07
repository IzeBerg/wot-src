package net.wg.gui.lobby.colorSettings.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class ColorSettingsVO extends DAAPIDataClass
   {
      
      private static const SETTINGS_TYPES_FIELD:String = "settingsTypes";
      
      private static const FILTERS_TYPES_FIELD:String = "filtersTypes";
       
      
      public var header:String = "";
      
      public var typesHeader:String = "";
      
      public var typesDesc:String = "";
      
      public var settingsTypesDP:DataProvider = null;
      
      public var cancelLabel:String = "";
      
      public var applyLabel:String = "";
      
      public var closeLabel:String = "";
      
      public var afterStr:String = "";
      
      public var beforeStr:String = "";
      
      public var filtersHeader:String = "";
      
      public var filterPowerLabel:String = "";
      
      public var filtersTypesDP:DataProvider = null;
      
      public var manualHeader:String = "";
      
      public var brightnessLabel:String = "";
      
      public var contrastLabel:String = "";
      
      public var saturationLabel:String = "";
      
      public var resetLabel:String = "";
      
      public function ColorSettingsVO(param1:Object = null)
      {
         super(param1);
      }
      
      private static function createDP(param1:Object) : DataProvider
      {
         var _loc4_:ColorSettingsRendererVO = null;
         var _loc5_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         var _loc3_:Array = param1 as Array;
         App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
         for each(_loc5_ in _loc3_)
         {
            _loc4_ = new ColorSettingsRendererVO(_loc5_);
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SETTINGS_TYPES_FIELD)
         {
            this.settingsTypesDP = createDP(param2);
            return false;
         }
         if(param1 == FILTERS_TYPES_FIELD)
         {
            this.filtersTypesDP = createDP(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.settingsTypesDP.cleanUp();
         this.settingsTypesDP = null;
         this.filtersTypesDP.cleanUp();
         this.filtersTypesDP = null;
         super.onDispose();
      }
   }
}
