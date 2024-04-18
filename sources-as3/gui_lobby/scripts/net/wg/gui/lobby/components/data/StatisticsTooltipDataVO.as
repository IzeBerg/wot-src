package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.managers.IToolTipParams;
   
   public class StatisticsTooltipDataVO extends DAAPIDataClass implements IToolTipParams
   {
       
      
      private var _header:Object = null;
      
      private var _body:Object = null;
      
      private var _note:Object = null;
      
      public function StatisticsTooltipDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._header = null;
         this._body = null;
         this._note = null;
         super.onDispose();
      }
      
      public function get header() : Object
      {
         return this._header;
      }
      
      public function set header(param1:Object) : void
      {
         this._header = param1;
      }
      
      public function get body() : Object
      {
         return this._body;
      }
      
      public function set body(param1:Object) : void
      {
         this._body = param1;
      }
      
      public function get note() : Object
      {
         return this._note;
      }
      
      public function set note(param1:Object) : void
      {
         this._note = param1;
      }
   }
}
