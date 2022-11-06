package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ComplexTooltipVO extends DAAPIDataClass
   {
       
      
      private var _header:String = "";
      
      private var _body:String = "";
      
      private var _note:String = "";
      
      public function ComplexTooltipVO(param1:Object)
      {
         super(param1);
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function set header(param1:String) : void
      {
         this._header = param1;
      }
      
      public function get body() : String
      {
         return this._body;
      }
      
      public function set body(param1:String) : void
      {
         this._body = param1;
      }
      
      public function get note() : String
      {
         return this._note;
      }
      
      public function set note(param1:String) : void
      {
         this._note = param1;
      }
   }
}
