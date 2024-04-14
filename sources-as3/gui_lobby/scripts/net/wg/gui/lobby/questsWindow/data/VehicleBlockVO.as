package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleBlockVO extends DAAPIDataClass
   {
       
      
      private var _nationID:int;
      
      private var _vIconSmall:String = "";
      
      private var _vType:String = "";
      
      private var _vLevel:int;
      
      private var _vName:String = "";
      
      private var _discount:String = "";
      
      public function VehicleBlockVO(param1:Object)
      {
         super(param1);
      }
      
      public function get nationID() : int
      {
         return this._nationID;
      }
      
      public function set nationID(param1:int) : void
      {
         this._nationID = param1;
      }
      
      public function get vType() : String
      {
         return this._vType;
      }
      
      public function set vType(param1:String) : void
      {
         this._vType = param1;
      }
      
      public function get vLevel() : int
      {
         return this._vLevel;
      }
      
      public function set vLevel(param1:int) : void
      {
         this._vLevel = param1;
      }
      
      public function get vName() : String
      {
         return this._vName;
      }
      
      public function set vName(param1:String) : void
      {
         this._vName = param1;
      }
      
      public function get nationIconPath() : String
      {
         var _loc1_:Array = App.utils.getNationNamesS();
         return "../maps/icons/filters/nations/" + _loc1_[this._nationID] + ".png";
      }
      
      public function get typeIconPath() : String
      {
         return "../maps/icons/filters/tanks/" + this._vType + ".png";
      }
      
      public function get vIconSmall() : String
      {
         return this._vIconSmall;
      }
      
      public function set vIconSmall(param1:String) : void
      {
         this._vIconSmall = param1;
      }
      
      public function get discount() : String
      {
         return this._discount;
      }
      
      public function set discount(param1:String) : void
      {
         this._discount = param1;
      }
   }
}
