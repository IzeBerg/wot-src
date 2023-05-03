package net.wg.gui.lobby.hangar.crew
{
   public class TankmanTextCreator
   {
      
      private static const DEBUFF:String = "#FF0000";
       
      
      private var _levelSpecializationMainHtml:String = null;
      
      private var _nameTF:String = null;
      
      private var _rank:String = null;
      
      private var _roleHtml:String = null;
      
      public function TankmanTextCreator(param1:TankmanVO, param2:TankmanRoleVO)
      {
         super();
         this._nameTF = param1.fullName;
         this._rank = param1.rank;
         this._roleHtml = param1.role;
         var _loc3_:String = param1.specializationLevel + "%";
         var _loc4_:String = App.utils.locale.makeString(MENU.tankmen(param1.tankType),{});
         if(isNaN(param1.tankmanID))
         {
            this._levelSpecializationMainHtml = "";
            this._roleHtml += ", " + _loc4_ + " " + param1.vehicleType;
         }
         else if(!param2.ignoreRoleIncompatibility && param2.tankType != param1.tankType)
         {
            this._levelSpecializationMainHtml = " <font color=\'" + DEBUFF + "\'>" + _loc3_ + "</font>";
            this._roleHtml += ", <font color=\'" + DEBUFF + "\'>" + _loc4_ + " " + param1.vehicleType + "</font>";
         }
         else if(!param2.ignoreRoleIncompatibility && param2.vehicleType != param1.vehicleType)
         {
            if(!param2.vehicleElite)
            {
               this._levelSpecializationMainHtml = " <font color=\'" + DEBUFF + "\'>" + _loc3_ + "</font>";
            }
            else
            {
               this._levelSpecializationMainHtml = _loc3_;
            }
            this._roleHtml += ", " + _loc4_ + " <font color=\'" + DEBUFF + "\'> " + param1.vehicleType + "</font>";
         }
         else
         {
            this._levelSpecializationMainHtml = !!param1.isLessMastered ? "<font color=\'#ffd387\'>" + _loc3_ + "</font>" : _loc3_;
            this._roleHtml += ", " + _loc4_ + " " + param1.vehicleType;
         }
      }
      
      public function get roleHtml() : String
      {
         return this._roleHtml;
      }
      
      public function get rank() : String
      {
         return this._rank;
      }
      
      public function get nameTF() : String
      {
         return this._nameTF;
      }
      
      public function get levelSpecializationMainHtml() : String
      {
         return this._levelSpecializationMainHtml;
      }
   }
}
