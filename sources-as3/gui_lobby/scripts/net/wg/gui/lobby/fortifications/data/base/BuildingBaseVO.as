package net.wg.gui.lobby.fortifications.data.base
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.fortBase.IBuildingBaseVO;
   
   public class BuildingBaseVO extends DAAPIDataClass implements IBuildingBaseVO
   {
       
      
      private var _defResVal:int = 0;
      
      private var _hpVal:int = 0;
      
      private var _buildingLevel:int = 0;
      
      private var _uid:String = "";
      
      private var _iconSource:String = "";
      
      private var _maxHpValue:uint = 0;
      
      private var _maxDefResValue:uint = 0;
      
      private var _animationType:int = -1;
      
      public function BuildingBaseVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get defResVal() : int
      {
         return this._defResVal;
      }
      
      public function set defResVal(param1:int) : void
      {
         this._defResVal = param1;
      }
      
      public function get hpVal() : int
      {
         return this._hpVal;
      }
      
      public function set hpVal(param1:int) : void
      {
         this._hpVal = param1;
      }
      
      public function get buildingLevel() : int
      {
         return this._buildingLevel;
      }
      
      public function set buildingLevel(param1:int) : void
      {
         this._buildingLevel = param1;
      }
      
      public function get uid() : String
      {
         return this._uid;
      }
      
      public function set uid(param1:String) : void
      {
         this._uid = param1;
      }
      
      public function get iconSource() : String
      {
         return this._iconSource;
      }
      
      public function set iconSource(param1:String) : void
      {
         this._iconSource = param1;
      }
      
      public function get maxHpValue() : uint
      {
         return this._maxHpValue;
      }
      
      public function set maxHpValue(param1:uint) : void
      {
         this._maxHpValue = param1;
      }
      
      public function get maxDefResValue() : uint
      {
         return this._maxDefResValue;
      }
      
      public function set maxDefResValue(param1:uint) : void
      {
         this._maxDefResValue = param1;
      }
      
      public function get animationType() : int
      {
         return this._animationType;
      }
      
      public function set animationType(param1:int) : void
      {
         this._animationType = param1;
      }
   }
}
