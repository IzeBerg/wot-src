package net.wg.data.managers.impl
{
   import net.wg.data.managers.IToolTipParams;
   
   public class ToolTipParams implements IToolTipParams
   {
       
      
      private var _header:Object;
      
      private var _body:Object;
      
      private var _note:Object;
      
      private var _disposed:Boolean = false;
      
      public function ToolTipParams(param1:Object = null, param2:Object = null, param3:Object = null)
      {
         super();
         this._header = param1;
         this._body = param2;
         this._note = param3;
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
         this._note = this.note;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._header = null;
         this._body = null;
         this._note = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
