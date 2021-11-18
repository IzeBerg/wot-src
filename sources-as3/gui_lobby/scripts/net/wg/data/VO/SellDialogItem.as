package net.wg.data.VO
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SellDialogItem implements IDisposable
   {
       
      
      private var _elements:Vector.<SellDialogElementVO>;
      
      private var _header:String;
      
      public function SellDialogItem()
      {
         super();
         this._elements = new Vector.<SellDialogElementVO>();
      }
      
      public final function dispose() : void
      {
         this._elements.splice(0,this._elements.length);
         this._elements = null;
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function set header(param1:String) : void
      {
         this._header = param1;
      }
      
      public function get elements() : Vector.<SellDialogElementVO>
      {
         return this._elements;
      }
      
      public function set elements(param1:Vector.<SellDialogElementVO>) : void
      {
         this._elements = param1;
      }
   }
}
