package net.wg.gui.components.common.markers.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleMarkerVO extends DAAPIDataClass
   {
       
      
      private var _vClass:String = "";
      
      private var _vIconSource:String = "";
      
      private var _vType:String = "";
      
      private var _vLevel:Number;
      
      private var _pFullName:String = "";
      
      private var _curHealth:Number;
      
      private var _maxHealth:Number;
      
      private var _entityName:String = "";
      
      private var _speaking:Boolean;
      
      private var _hunt:Boolean;
      
      private var _entityType:String = "";
      
      private var _vDist:String = "";
      
      public function VehicleMarkerVO(param1:Object)
      {
         super(param1);
      }
      
      public function get vClass() : String
      {
         return this._vClass;
      }
      
      public function set vClass(param1:String) : void
      {
         this._vClass = param1;
      }
      
      public function get vIconSource() : String
      {
         return this._vIconSource;
      }
      
      public function set vIconSource(param1:String) : void
      {
         this._vIconSource = param1;
      }
      
      public function get vType() : String
      {
         return this._vType;
      }
      
      public function set vType(param1:String) : void
      {
         this._vType = param1;
      }
      
      public function get vLevel() : Number
      {
         return this._vLevel;
      }
      
      public function set vLevel(param1:Number) : void
      {
         this._vLevel = param1;
      }
      
      public function get pFullName() : String
      {
         return this._pFullName;
      }
      
      public function set pFullName(param1:String) : void
      {
         this._pFullName = param1;
      }
      
      public function get curHealth() : Number
      {
         return this._curHealth;
      }
      
      public function set curHealth(param1:Number) : void
      {
         this._curHealth = param1;
      }
      
      public function get maxHealth() : Number
      {
         return this._maxHealth;
      }
      
      public function set maxHealth(param1:Number) : void
      {
         this._maxHealth = param1;
      }
      
      public function get entityName() : String
      {
         return this._entityName;
      }
      
      public function set entityName(param1:String) : void
      {
         this._entityName = param1;
      }
      
      public function get speaking() : Boolean
      {
         return this._speaking;
      }
      
      public function set speaking(param1:Boolean) : void
      {
         this._speaking = param1;
      }
      
      public function get hunt() : Boolean
      {
         return this._hunt;
      }
      
      public function set hunt(param1:Boolean) : void
      {
         this._hunt = param1;
      }
      
      public function get entityType() : String
      {
         return this._entityType;
      }
      
      public function set entityType(param1:String) : void
      {
         this._entityType = param1;
      }
      
      public function get vDist() : String
      {
         return this._vDist;
      }
      
      public function set vDist(param1:String) : void
      {
         this._vDist = param1;
      }
   }
}
