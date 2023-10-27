package net.wg.gui.components.tooltips.VO
{
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class TankmenVO
   {
       
      
      public var vName:String = "";
      
      public var rank:String = "";
      
      public var vehicleContour:String = "";
      
      public var currentVehicleType:String = "";
      
      public var params:Array = null;
      
      public var vehicleName:String = "";
      
      public var currentVehicleName:String = "";
      
      public var isCurrentVehiclePremium:Boolean = false;
      
      public var newSkillsCount:Number = 0;
      
      public var status:Boolean = false;
      
      public var statusHeader:String = null;
      
      public var statusLevel:String = null;
      
      public var statusText:String = null;
      
      public function TankmenVO(param1:Object)
      {
         super();
         this.parsHash(param1);
      }
      
      private function parsHash(param1:Object) : void
      {
         var _loc10_:uint = 0;
         this.vName = param1.hasOwnProperty("name") && param1["name"] != undefined ? param1["name"] : "";
         this.rank = param1.hasOwnProperty("rank") && param1["rank"] != undefined ? param1["rank"] : "";
         this.vehicleContour = param1.hasOwnProperty("vehicleContour") && param1["vehicleContour"] != undefined ? param1["vehicleContour"] : "";
         this.currentVehicleType = param1.hasOwnProperty("currentVehicleType") && param1["currentVehicleType"] != undefined ? param1["currentVehicleType"] : "";
         this.newSkillsCount = param1.hasOwnProperty("newSkillsCount") && param1["newSkillsCount"] != undefined ? Number(param1["newSkillsCount"]) : Number(0);
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:String = "";
         _loc2_ = param1.hasOwnProperty("roleLevel") && param1["roleLevel"] != undefined ? Number(param1["roleLevel"]) : Number(0);
         _loc3_ = param1.hasOwnProperty("penalty") && param1["penalty"] != undefined ? Number(param1["penalty"]) : Number(0);
         _loc4_ = param1.hasOwnProperty("addition") && param1["addition"] != undefined ? Number(param1["addition"]) : Number(0);
         var _loc6_:String = _loc4_ == 0 ? "" : this.getSign(_loc4_) + _loc4_.toString();
         var _loc7_:String = _loc3_ == 0 ? "" : this.getSign(_loc3_) + _loc3_.toString();
         if(_loc3_ != 0 || _loc4_ != 0)
         {
            _loc5_ = " (" + _loc2_ + _loc6_ + _loc7_ + ")";
         }
         else
         {
            _loc5_ = "";
         }
         _loc2_ += _loc3_ + _loc4_;
         this.vehicleName = param1.hasOwnProperty("vehicleName") && param1["vehicleName"] != undefined ? param1["vehicleName"] : "";
         this.currentVehicleName = param1.hasOwnProperty("currentVehicleName") && param1["currentVehicleName"] != undefined ? param1["currentVehicleName"] : "";
         this.isCurrentVehiclePremium = param1.hasOwnProperty("isCurrentVehiclePremium") && param1["isCurrentVehiclePremium"] != undefined ? Boolean(param1["isCurrentVehiclePremium"]) : Boolean(false);
         var _loc8_:String = _loc3_ < 0 ? Utils.instance.COLOR_ALERT : Utils.instance.COLOR_NORMAL;
         this.params = [];
         this.params[0] = [];
         this.params[0][0] = param1.role;
         this.params[0][1] = Utils.instance.htmlWrapper(_loc2_.toString() + "%" + _loc5_,_loc8_,12,"$TextFont");
         var _loc9_:Array = !!param1.hasOwnProperty("skills") ? param1["skills"] : [];
         if(_loc9_.length > 0 && _loc9_[0].id != "new_skill")
         {
            _loc10_ = 0;
            while(_loc10_ < _loc9_.length)
            {
               this.params[_loc10_ + 1] = [];
               this.params[_loc10_ + 1][0] = _loc9_[_loc10_].hasOwnProperty("label") && _loc9_[_loc10_]["label"] != undefined ? _loc9_[_loc10_]["label"] : "";
               this.params[_loc10_ + 1][1] = _loc9_[_loc10_].hasOwnProperty("level") && _loc9_[_loc10_]["level"] != undefined ? _loc9_[_loc10_]["level"] + "%" : "";
               this.params[_loc10_ + 1][2] = _loc9_[_loc10_].hasOwnProperty("enabled") && _loc9_[_loc10_]["enabled"] != undefined ? _loc9_[_loc10_]["enabled"] : "";
               _loc10_++;
            }
         }
         if(param1.hasOwnProperty("status") && param1["status"] != undefined)
         {
            this.statusHeader = param1["status"].hasOwnProperty("header") && param1["status"]["header"] != undefined ? param1["status"]["header"] : "";
            this.statusLevel = param1["status"].hasOwnProperty("level") && param1["status"]["level"] != undefined ? param1["status"]["level"] : "";
            this.statusText = param1["status"].hasOwnProperty("text") && param1["status"]["text"] != undefined ? param1["status"]["text"] : "";
         }
         else
         {
            this.statusHeader = null;
            this.statusLevel = null;
            this.statusText = null;
         }
         if(this.statusHeader || this.statusText)
         {
            this.status = true;
         }
      }
      
      private function getSign(param1:Number) : String
      {
         return param1 >= 0 ? "+" : "";
      }
   }
}
