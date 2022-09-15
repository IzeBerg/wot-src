package net.wg.data.utilData
{
   public class TankmanRoleLevel
   {
       
      
      private var _roleLevel:uint;
      
      private var _common:int;
      
      private var _brotherhood:int;
      
      private var _equipment:int;
      
      private var _optDevs:int;
      
      private var _penalty:int;
      
      public function TankmanRoleLevel(param1:uint, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super();
         this._roleLevel = param1;
         this._common = param2;
         this._brotherhood = param3;
         this._equipment = param4;
         this._optDevs = param5;
         this._penalty = param6;
      }
      
      public function get roleLevel() : uint
      {
         return this._roleLevel;
      }
      
      public function get common() : uint
      {
         return this._common;
      }
      
      public function get brotherhood() : uint
      {
         return this._brotherhood;
      }
      
      public function get equipment() : uint
      {
         return this._equipment;
      }
      
      public function get optDevs() : uint
      {
         return this._optDevs;
      }
      
      public function get penalty() : uint
      {
         return this._penalty;
      }
   }
}
