package net.wg.gui.components.carousels.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class FilterCarouseInitVO extends DAAPIDataClass
   {
      
      private static const NATIONS_TYPES:String = "nations";
      
      private static const VEHICLE_TYPES:String = "vehicleTypes";
      
      private static const LEVELS_TYPES:String = "levels";
      
      private static const SPECIALS:String = "specials";
      
      private static const HIDDEN:String = "hidden";
      
      private static const PROGRESSIONS:String = "progressions";
      
      private static const ROLES:String = "roles";
       
      
      public var titleLabel:String = "";
      
      public var nationsLabel:String = "";
      
      public var vehicleTypesLabel:String = "";
      
      public var levelsLabel:String = "";
      
      public var specialsLabel:String = "";
      
      public var hiddenLabel:String = "";
      
      public var progressionsLabel:String = "";
      
      public var rolesLabel:String = "";
      
      public var toggleSwitchCarouselIcon:String = "";
      
      public var searchInputLabel:String = "";
      
      public var searchInputName:String = "";
      
      public var searchInputTooltip:String = "";
      
      public var searchInputMaxChars:int = -1;
      
      public var hiddenSectionVisible:Boolean = false;
      
      public var specialSectionVisible:Boolean = false;
      
      public var tankTierSectionVisible:Boolean = false;
      
      public var searchSectionVisible:Boolean = false;
      
      public var progressionsSectionVisible:Boolean = false;
      
      public var rolesSectionVisible:Boolean = false;
      
      public var changeableArrowDirection:Boolean = false;
      
      public var nationsSectionId:int = -1;
      
      public var vehicleTypesSectionId:int = -1;
      
      public var levelsSectionId:int = -1;
      
      public var specialSectionId:int = -1;
      
      public var hiddenSectionId:int = -1;
      
      public var progressionsSectionId:int = -1;
      
      public var rolesSectionId:int = -1;
      
      public var toggleSwitchCarouselTooltip:String = "";
      
      public var toggleSwitchCarouselSelected:Boolean = false;
      
      private var _nations:DataProvider = null;
      
      private var _vehicleTypes:DataProvider = null;
      
      private var _levels:DataProvider = null;
      
      private var _specials:DataProvider = null;
      
      private var _hidden:DataProvider = null;
      
      private var _progressions:DataProvider = null;
      
      private var _roles:FilterRoleInitVO = null;
      
      public function FilterCarouseInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc3_:Object = null;
         if(param1 == NATIONS_TYPES)
         {
            this._nations = new DataProvider();
            for each(_loc4_ in param2)
            {
               this._nations.push(new SimpleRendererVO(_loc4_));
            }
            return false;
         }
         if(param1 == VEHICLE_TYPES)
         {
            this._vehicleTypes = new DataProvider();
            for each(_loc5_ in param2)
            {
               this._vehicleTypes.push(new SimpleRendererVO(_loc5_));
            }
            return false;
         }
         if(param1 == LEVELS_TYPES)
         {
            this._levels = new DataProvider();
            for each(_loc6_ in param2)
            {
               this._levels.push(new SimpleRendererVO(_loc6_));
            }
            return false;
         }
         if(param1 == SPECIALS)
         {
            this._specials = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._specials.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == HIDDEN)
         {
            this._hidden = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._hidden.push(new CheckBoxRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == ROLES)
         {
            this._roles = new FilterRoleInitVO(param2);
            return false;
         }
         if(param1 == PROGRESSIONS)
         {
            this._progressions = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._progressions.push(new SimpleRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._nations)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._vehicleTypes)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._levels)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._specials)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._hidden)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this._progressions)
         {
            _loc1_.dispose();
         }
         this._nations.cleanUp();
         this._nations = null;
         this._vehicleTypes.cleanUp();
         this._vehicleTypes = null;
         this._specials.cleanUp();
         this._specials = null;
         this._levels.cleanUp();
         this._levels = null;
         this._hidden.cleanUp();
         this._hidden = null;
         this._progressions.cleanUp();
         this._progressions = null;
         this._roles.dispose();
         this._roles = null;
         super.onDispose();
      }
      
      public function get vehicleTypes() : DataProvider
      {
         return this._vehicleTypes;
      }
      
      public function get specials() : DataProvider
      {
         return this._specials;
      }
      
      public function get hidden() : DataProvider
      {
         return this._hidden;
      }
      
      public function get levels() : DataProvider
      {
         return this._levels;
      }
      
      public function get nations() : DataProvider
      {
         return this._nations;
      }
      
      public function get progressions() : DataProvider
      {
         return this._progressions;
      }
      
      public function get roles() : FilterRoleInitVO
      {
         return this._roles;
      }
   }
}
