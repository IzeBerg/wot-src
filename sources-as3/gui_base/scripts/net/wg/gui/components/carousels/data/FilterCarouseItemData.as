package net.wg.gui.components.carousels.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class FilterCarouseItemData implements IDisposable
   {
       
      
      private var _sectionId:int = -1;
      
      private var _label:String = "";
      
      private var _dataProvider:DataProvider = null;
      
      private var _disposed:Boolean = false;
      
      public function FilterCarouseItemData(param1:int, param2:String, param3:DataProvider)
      {
         super();
         this._sectionId = param1;
         this._label = param2;
         this._dataProvider = param3;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function onDispose() : void
      {
         this._dataProvider = null;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function get sectionId() : int
      {
         return this._sectionId;
      }
      
      public function get dataProvider() : DataProvider
      {
         return this._dataProvider;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
