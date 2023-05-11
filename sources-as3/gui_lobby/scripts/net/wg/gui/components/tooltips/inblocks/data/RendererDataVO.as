package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RendererDataVO extends DAAPIDataClass
   {
      
      private static const VAL_DATA:String = "data";
      
      private static const VAL_DATA_TYPE:String = "dataType";
       
      
      public var rendererType:String = "";
      
      public var _data;
      
      private var _dataType:Class;
      
      public function RendererDataVO(param1:Object = null)
      {
         this._dataType = App.utils.classFactory.getClass(param1[VAL_DATA_TYPE]);
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VAL_DATA_TYPE)
         {
            return false;
         }
         if(param1 == VAL_DATA)
         {
            this._data = new this.dataType(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._dataType = null;
         if(this._data is IDisposable)
         {
            IDisposable(this._data).dispose();
         }
         this._data = null;
         super.onDispose();
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      protected function get dataType() : Class
      {
         return this._dataType;
      }
   }
}
