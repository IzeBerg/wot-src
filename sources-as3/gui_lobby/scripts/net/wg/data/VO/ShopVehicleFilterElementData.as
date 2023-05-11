package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ShopVehicleFilterElementData extends DAAPIDataClass
   {
       
      
      private var _id:String = "";
      
      private var _nation:int = -1;
      
      private var _name:String = "";
      
      public function ShopVehicleFilterElementData(param1:Object)
      {
         super(param1);
      }
      
      public function get nation() : int
      {
         return this._nation;
      }
      
      public function set nation(param1:int) : void
      {
         this._nation = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
   }
}
