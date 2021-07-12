package net.wg.gui.components.carousels.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FiltersStateVO extends DAAPIDataClass
   {
      
      private static const NATIONS_SELECTED:String = "nations";
      
      private static const VEHICLE_TYPES_SELECTED:String = "vehicleTypes";
      
      private static const SPECIAL_SELECTED:String = "specials";
      
      private static const LEVELS_SELECTED:String = "levels";
      
      private static const HIDDEN_SELECTED:String = "hidden";
      
      private static const PROGRESSIONS_SELECTED:String = "progressions";
      
      private static const ROLES_STATES:String = "roles";
       
      
      public var rolesSectionVisible:Boolean = false;
      
      public var rolesLabel:String = "";
      
      private var _nationsSelected:Vector.<Boolean> = null;
      
      private var _vehicleTypesSelected:Vector.<Boolean> = null;
      
      private var _specialsSelected:Vector.<Boolean> = null;
      
      private var _levelsSelected:Vector.<Boolean> = null;
      
      private var _hiddenSelected:Vector.<Boolean> = null;
      
      private var _rolesStates:FilterRoleStateVO = null;
      
      private var _progressionsSelected:Vector.<Boolean> = null;
      
      public function FiltersStateVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1 == NATIONS_SELECTED)
         {
            this._nationsSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._nationsSelected.push(_loc3_);
            }
            return false;
         }
         if(param1 == VEHICLE_TYPES_SELECTED)
         {
            this._vehicleTypesSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._vehicleTypesSelected.push(_loc3_);
            }
            return false;
         }
         if(param1 == SPECIAL_SELECTED)
         {
            this._specialsSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._specialsSelected.push(_loc3_);
            }
            return false;
         }
         if(param1 == LEVELS_SELECTED)
         {
            this._levelsSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._levelsSelected.push(_loc3_);
            }
            return false;
         }
         if(param1 == HIDDEN_SELECTED)
         {
            this._hiddenSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._hiddenSelected.push(_loc3_);
            }
            return false;
         }
         if(param1 == ROLES_STATES)
         {
            this._rolesStates = new FilterRoleStateVO(param2);
            return false;
         }
         if(param1 == PROGRESSIONS_SELECTED)
         {
            this._progressionsSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2)
            {
               this._progressionsSelected.push(_loc3_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._nationsSelected.splice(0,this._nationsSelected.length);
         this._nationsSelected = null;
         this._vehicleTypesSelected.splice(0,this._vehicleTypesSelected.length);
         this._vehicleTypesSelected = null;
         this._specialsSelected.splice(0,this._specialsSelected.length);
         this._specialsSelected = null;
         this._levelsSelected.splice(0,this._levelsSelected.length);
         this._levelsSelected = null;
         this._hiddenSelected.splice(0,this._hiddenSelected.length);
         this._hiddenSelected = null;
         this._rolesStates.dispose();
         this._rolesStates = null;
         this._progressionsSelected.splice(0,this._progressionsSelected.length);
         this._progressionsSelected = null;
         super.onDispose();
      }
      
      public function get nationsSelected() : Vector.<Boolean>
      {
         return this._nationsSelected;
      }
      
      public function get vehicleTypesSelected() : Vector.<Boolean>
      {
         return this._vehicleTypesSelected;
      }
      
      public function get specialsSelected() : Vector.<Boolean>
      {
         return this._specialsSelected;
      }
      
      public function get levelsSelected() : Vector.<Boolean>
      {
         return this._levelsSelected;
      }
      
      public function get hiddenSelected() : Vector.<Boolean>
      {
         return this._hiddenSelected;
      }
      
      public function get progressionsSelected() : Vector.<Boolean>
      {
         return this._progressionsSelected;
      }
      
      public function get rolesStates() : FilterRoleStateVO
      {
         return this._rolesStates;
      }
   }
}
