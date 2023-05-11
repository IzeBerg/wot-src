package net.wg.gui.lobby.hangar.crew
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class TankmenResponseVO extends DAAPIDataClass
   {
      
      private static const ROLES:String = "roles";
      
      private static const TANKMEN:String = "tankmen";
      
      private static const SPECIALIZATION_LEVEL:int = 101;
      
      private static const ICON_PATH:String = "img://gui/maps/icons/tankmen/icons/small/";
      
      private static const USSR_EMPTY:String = "ussr-empty.png";
      
      private static const GERMANY_EMPTY:String = "germany-empty.png";
       
      
      public var showRecruit:Boolean = true;
      
      private var _roles:Vector.<TankmanRoleVO> = null;
      
      private var _tankmen:Vector.<TankmanVO>;
      
      private var _listDP:DataProvider = null;
      
      public function TankmenResponseVO(param1:Object)
      {
         super(param1);
         this.createListDP();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         if(param1 == ROLES)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            this._roles = new Vector.<TankmanRoleVO>(0);
            for each(_loc4_ in _loc3_)
            {
               this._roles.push(new TankmanRoleVO(_loc4_));
            }
            return false;
         }
         if(param1 == TANKMEN)
         {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_,Errors.INVALID_TYPE + Array);
            this._tankmen = new Vector.<TankmanVO>(0);
            for each(_loc6_ in _loc5_)
            {
               this._tankmen.push(new TankmanVO(_loc6_));
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._listDP)
         {
            _loc1_.dispose();
         }
         this._listDP.cleanUp();
         this._listDP = null;
         super.onDispose();
      }
      
      private function getTankman(param1:int) : TankmanVO
      {
         var _loc2_:TankmanVO = null;
         for each(_loc2_ in this._tankmen)
         {
            if(_loc2_.tankmanID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function createListDP() : void
      {
         var _loc1_:TankmanRoleVO = null;
         var _loc2_:IDisposable = null;
         var _loc3_:TankmanRoleVO = null;
         var _loc4_:TankmanVO = null;
         var _loc5_:TankmanVO = null;
         var _loc6_:TankmanVO = null;
         var _loc7_:TankmanVO = null;
         this._listDP = new DataProvider();
         for each(_loc1_ in this._roles)
         {
            _loc3_ = _loc1_.clone();
            if(_loc3_.tankmanID)
            {
               _loc7_ = this.getTankman(_loc3_.tankmanID);
               App.utils.asserter.assertNotNull(_loc7_,"Requested tankmanID \'" + _loc3_.tankmanID + "\' is not found in supplied \'tankmen\' list!");
               _loc3_.tankman = TankmanVO(_loc7_.clone());
            }
            else
            {
               _loc3_.tankman = new TankmanVO({
                  "iconFile":ICON_PATH + (_loc3_.nationID == 0 ? USSR_EMPTY : GERMANY_EMPTY),
                  "role":_loc3_.role,
                  "roleIconFile":_loc3_.roleIcon,
                  "vehicleType":_loc3_.vehicleType,
                  "tankType":_loc3_.tankType,
                  "roleType":_loc3_.roleType,
                  "roles":_loc3_.roles
               });
            }
            _loc3_.tankman.currentRole = _loc3_;
            if(this.showRecruit)
            {
               _loc4_ = _loc3_.tankman.clone();
               _loc4_.tankmanID = Number.NaN;
               _loc4_.recruit = true;
               _loc4_.specializationLevel = SPECIALIZATION_LEVEL;
               _loc4_.currentRole = _loc3_;
               _loc3_.addRecruit(_loc4_);
            }
            if(_loc3_.tankmanID)
            {
               _loc4_ = _loc3_.tankman.clone();
               _loc4_.tankmanID = Number.NaN;
               _loc4_.personalCase = true;
               _loc4_.specializationLevel = SPECIALIZATION_LEVEL;
               _loc4_.currentRole = _loc3_;
               _loc3_.addRecruit(_loc4_);
            }
            for each(_loc6_ in this._tankmen)
            {
               if(_loc6_.roleType == _loc3_.roleType && _loc6_.nationID == _loc3_.nationID)
               {
                  if(!_loc6_.inTank)
                  {
                     _loc5_ = _loc6_.clone();
                     _loc3_.addRecruit(_loc5_);
                     _loc5_.currentRole = _loc3_;
                  }
                  else if(_loc6_.tankmanID == _loc3_.tankmanID)
                  {
                     _loc5_ = _loc6_.clone();
                     _loc3_.addRecruit(_loc5_);
                     _loc5_.currentRole = _loc3_;
                     _loc5_.selected = true;
                  }
               }
            }
            _loc3_.sortRecruits();
            this._listDP.push(_loc3_);
         }
         for each(_loc2_ in this._roles)
         {
            _loc2_.dispose();
         }
         this._roles.splice(0,this._roles.length);
         this._roles = null;
         for each(_loc2_ in this._tankmen)
         {
            _loc2_.dispose();
         }
         this._tankmen.splice(0,this._tankmen.length);
         this._tankmen = null;
      }
      
      public function get listDP() : IDataProvider
      {
         return this._listDP;
      }
   }
}
