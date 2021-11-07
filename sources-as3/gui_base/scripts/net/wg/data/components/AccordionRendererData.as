package net.wg.data.components
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AccordionRendererData extends DAAPIDataClass
   {
       
      
      private var _label:String = "";
      
      private var _linkage:String = "";
      
      private var _enabled:Boolean = false;
      
      public function AccordionRendererData(param1:Object)
      {
         super(param1);
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
      }
   }
}
