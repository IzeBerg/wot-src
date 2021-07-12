package net.wg.gui.lobby.profile.pages.technique.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SortingSettingVO extends DAAPIDataClass
   {
       
      
      private var _btnType:String = "";
      
      private var _sortDirection:String = "";
      
      public function SortingSettingVO(param1:Object)
      {
         super(param1);
      }
      
      public function get btnType() : String
      {
         return this._btnType;
      }
      
      public function set btnType(param1:String) : void
      {
         this._btnType = param1;
      }
      
      public function get sortDirection() : String
      {
         return this._sortDirection;
      }
      
      public function set sortDirection(param1:String) : void
      {
         this._sortDirection = param1;
      }
   }
}
