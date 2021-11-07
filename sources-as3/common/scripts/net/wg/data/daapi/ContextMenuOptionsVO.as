package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.IContextItem;
   
   public class ContextMenuOptionsVO extends DAAPIDataClass
   {
      
      private static const OPTIONS_FIELD:String = "options";
       
      
      private var _options:Vector.<IContextItem>;
      
      public function ContextMenuOptionsVO(param1:Object)
      {
         super(param1);
      }
      
      public function get options() : Vector.<IContextItem>
      {
         return this._options;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == OPTIONS_FIELD)
         {
            this._writeItems(param2 as Array);
            return false;
         }
         return true;
      }
      
      private function _writeItems(param1:Array) : void
      {
         var _loc2_:Object = null;
         this._options = new Vector.<IContextItem>();
         for each(_loc2_ in param1)
         {
            this._options.push(new ContextMenuOptionVO(_loc2_));
         }
      }
   }
}
