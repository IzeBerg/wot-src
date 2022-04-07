package net.wg.gui.lobby.hangar.crew
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TankmanRoleVO extends DAAPIDataClass
   {
      
      private static const ROLES:String = "roles";
       
      
      public var tankmanID:Number = NaN;
      
      public var roleType:String = "";
      
      public var role:String = "";
      
      public var roleIcon:String = "";
      
      public var nationID:int = -1;
      
      public var typeID:int = -1;
      
      public var slot:int = -1;
      
      public var vehicleType:String = "";
      
      public var tankType:String = "";
      
      public var vehicleElite:Boolean = false;
      
      public var roles:Vector.<String>;
      
      public var tankman:TankmanVO = null;
      
      public var recruitList:Array;
      
      public function TankmanRoleVO(param1:Object = null)
      {
         this.roles = new Vector.<String>(0);
         this.recruitList = [];
         super(param1);
      }
      
      private static function sortRecruitsFunc(param1:TankmanVO, param2:TankmanVO) : Number
      {
         if(param1.personalCase && !param2.personalCase)
         {
            return -1;
         }
         if(!param1.personalCase && param2.personalCase)
         {
            return 1;
         }
         if(param1.recruit && !param2.recruit)
         {
            return -1;
         }
         if(!param1.recruit && param2.recruit)
         {
            return 1;
         }
         if(param1.selected && !param2.selected)
         {
            return -1;
         }
         if(!param1.selected && param2.selected)
         {
            return 1;
         }
         if(param1.specializationLevel > param2.specializationLevel)
         {
            return -1;
         }
         if(param1.specializationLevel < param2.specializationLevel)
         {
            return 1;
         }
         return 0;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:Boolean = true;
         if(param1 == ROLES)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,Errors.INVALID_TYPE + Array);
            for each(_loc5_ in _loc4_)
            {
               this.roles.push(_loc5_);
            }
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      override protected function onDispose() : void
      {
         this.roles.splice(0,this.roles.length);
         this.roles = null;
         if(this.tankman)
         {
            this.tankman.dispose();
            this.tankman = null;
         }
         var _loc1_:int = this.recruitList.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.recruitList[_loc2_].dispose();
            _loc2_++;
         }
         this.recruitList.splice(0,_loc1_);
         this.recruitList = null;
         super.onDispose();
      }
      
      public function addRecruit(param1:TankmanVO) : void
      {
         this.recruitList.push(param1);
      }
      
      public function sortRecruits() : void
      {
         this.recruitList.sort(sortRecruitsFunc);
      }
   }
}
